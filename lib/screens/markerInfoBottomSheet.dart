import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class MarkerInfoBottomSheet extends StatelessWidget {
  String name, location;
  int availableslots, occupiedslots, price;
  MarkerInfoBottomSheet({Key? key, required this.name, required this.location, required this.availableslots, required this.occupiedslots, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.8,
        builder: (BuildContext context, ScrollController scrollController){
          return Container(
            height: 500,
            decoration: BoxDecoration(
                color: Color(0xFFEAF9FE),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30) )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
              child: Column(
                children: [
                  Container(
                    height: 3,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              location,
                              style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                      ],
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              availableslots.toString(),
                              style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
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
                              style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
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
                              style: TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                                "Rs per hour"
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Information",
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ReadMoreText(
                    "Hello",
                    trimLines: 2,
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
                      color: Colors.white,
                    ),

                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
