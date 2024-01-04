import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkerInfoBottomSheet extends StatelessWidget {
  String name, location, contact, information, imageUrl;
  int availableslots, occupiedslots, price;
  GeoPoint parkingLocation;

  MarkerInfoBottomSheet(
      {Key? key, required this.name, required this.location, required this.availableslots, required this.occupiedslots, required this.price,
        required this.contact, required this.parkingLocation, required this.information, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.63,
        minChildSize: 0.63,
        maxChildSize: 0.65,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            height: 500,
            decoration: BoxDecoration(
                color: Color(0xFFEAF9FE),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30), topRight: Radius.circular(30))
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 20, top: 10),
              child: ListView(
                controller: scrollController,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 3,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                imageUrl,
                              ),
                              fit: BoxFit.fill,
                            )
                        ),
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Card(
                          color: Colors.black.withOpacity(0.3),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  location,
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              availableslots.toString(),
                              style: TextStyle(color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Available slots"
                            )
                          ],
                        ),
                        const VerticalDivider(
                          color: Colors.blueGrey,
                          thickness: 1.5,
                          indent: 10,
                          endIndent: 10,

                        ),
                        Column(
                          children: [
                            Text(
                              occupiedslots.toString(),
                              style: TextStyle(color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Occupied slots"
                            )
                          ],
                        ),
                        const VerticalDivider(
                          color: Colors.blueGrey,
                          thickness: 1.5,
                          indent: 10,
                          endIndent: 10,

                        ),
                        Column(
                          children: [
                            Text(
                              price.toString(),
                              style: TextStyle(color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Rs per hour"
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Information",
                      style: TextStyle(color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ReadMoreText(
                    information,
                    trimLines: 5,
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "more",
                    trimExpandedText: "less",
                    lessStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                    moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 150,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: contact,
                            );
                            _makePhoneCall(url);
                          },
                          icon: Icon(Icons.call),
                          label: Text("Call"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1E1E1E),
                              foregroundColor: Colors.white
                          ),
                        ),
                      ),
                      // SizedBox(width: 20,),
                      Container(
                        width: 150,
                        height: 45,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            double lat_parking = parkingLocation.latitude;
                            double lng_parking = parkingLocation.longitude;
                            String url = "https://www.google.com/maps/search/?api=1&query= $lat_parking, $lng_parking";
                            launchGoogleMap(url);
                          },
                          icon: Icon(Icons.directions),
                          label: Text("Direction"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1E1E1E),
                              foregroundColor: Colors.white
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  Future<void> _makePhoneCall(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch $url');
    }
  }

  Future<void> launchGoogleMap(String url) async {
    print("Url -----------------"+url);
    Uri googleUrl = Uri(
      path: url,
    );

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl);
    }
    else{
      print("Error launching google map");
    }
  }
}