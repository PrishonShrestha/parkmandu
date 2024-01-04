import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parkmandu/widgets/markerInfoBottomSheet.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

import '../widgets/menuDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Location _locationController = new Location();
  LatLng? _currentP = null;
  final Set<Marker> _markers = {};
  late GoogleMapController mapController;


  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: MenuDrawer(),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('parkings').snapshots(),
          //BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Text('Loading');
            }
            snapshot.data!.docs.forEach((doc) {
              var marker = Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(doc['latlng'].latitude, doc['latlng'].longitude),
                icon: doc['availableslots']==0 ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange) : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                infoWindow: InfoWindow(
                  title: doc['availableslots'].toString()+"/"+doc['totalslots'].toString(),
                ),
                onTap: (){
                  showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return MarkerInfoBottomSheet(name: doc['name'],location: doc['location'], availableslots: doc['availableslots'], occupiedslots: doc['occupiedslots'],
                        price: doc['price'], contact: doc['contact'], parkingLocation: doc['latlng'], information: doc['information'], imageUrl: doc['imageUrl'],);
                    },
                  );
                }
              );
              _markers.add(marker);
            });
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  compassEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: _currentP!,
                    //target: LatLng(27.700769, 85.300140),
                    zoom: 13,
                  ),
                  markers: _markers,
                  mapToolbarEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                  onTap: (position){
                  },
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  right: 15,
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          iconSize: 30,
                            onPressed: (){
                              Scaffold.of(context).openDrawer();
                            },
                            icon: Icon(Icons.menu, color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: size.width*0.72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: SearchMapPlaceWidget(
                          bgColor: Colors.transparent,
                          textColor: Colors.grey,
                          hasClearButton: true,
                          iconColor: Colors.grey,
                          placeType: PlaceType.address,
                          language: 'en',
                          placeholder: 'Search location',
                          apiKey: "AIzaSyCMbI8Qkc2r-I3dVUitA8UzrEmqj4TDrl4",
                          onSelected: (Place place) async {
                            Geolocation? geolocation = await place.geolocation;
                            mapController.animateCamera(
                                CameraUpdate.newLatLng(geolocation?.coordinates)
                            );
                            mapController.animateCamera(
                                CameraUpdate.newLatLngBounds(geolocation?.bounds, 0)
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            );
          },
        )
    );

  }

  //Function to get currrent location of users
  Future<void> getCurrentLocation() async{
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null){
        _currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
        var marker = Marker(
          markerId: MarkerId("_currentLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: _currentP!,
        );
        setState(() {
          //_currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _markers.add(marker);
        });
        print(_currentP);
      }
    });

  }

}


