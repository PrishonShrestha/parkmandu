import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parkmandu/screens/markerInfoBottomSheet.dart';

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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('parkings').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Text('Loading');
            }
            snapshot.data!.docs.forEach((doc) {
              var marker = Marker(
                markerId: MarkerId(doc.id),
                position: LatLng(doc['latlng'].latitude, doc['latlng'].longitude),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                  title: doc['availableslots'].toString()+"/"+doc['totalslots'].toString(),
                ),
                onTap: (){
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext context) {
                      return MarkerInfoBottomSheet(name: doc['name'],location: doc['location'], availableslots: doc['availableslots'], occupiedslots: doc['occupiedslots'], price: doc['price']);
                    },
                  );
                  //bottomSheet(doc['name'], doc['location'], doc['availableslots'], doc['occupiedslots'], doc['price']);
                }
              );
              _markers.add(marker);
            });
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _currentP!,
                    //target: LatLng(27.700769, 85.300140),
                    zoom: 13,
                  ),
                  markers: _markers,

                  onMapCreated: (GoogleMapController controller) {
                    setState(() {

                    });
                  },
                  onTap: (position){

                  },
                ),


              ],
            );
          },
        )
    );

  }

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


