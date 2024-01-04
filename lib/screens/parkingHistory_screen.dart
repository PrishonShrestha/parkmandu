import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ParkingHistory extends StatefulWidget {
  ParkingHistory({super.key});

  @override
  State<ParkingHistory> createState() => _ParkingHistoryState();
}

class _ParkingHistoryState extends State<ParkingHistory> {
  final TextEditingController _txtCardNumber = TextEditingController();
  List<Map<String, dynamic>> _parkingHistory = [];


  Future<void> searchParkingHistory() async {
    String rfidNumber = _txtCardNumber.text;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('parking_history')
        .where('userid', isEqualTo: rfidNumber)
        .get();

    setState(() {
      _parkingHistory = querySnapshot.docs
          .map((DocumentSnapshot document) => document.data() as Map<String, dynamic>)
          .toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
        title: Text("Parking history"),
        centerTitle: true,
        backgroundColor: Color(0xFFADD8E6),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              //controller: _searchController,
              controller: _txtCardNumber,
              decoration: InputDecoration(labelText: 'Enter rfid number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                searchParkingHistory();
              },
              child: Text('Search'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _parkingHistory.length,
                itemBuilder: (context, index) {
                  return
                    _parkingHistory.length !=0 ?
                    Card(
                    child: Column(
                      children: [
                        Text("RFID: "+_parkingHistory[index]['userid']),
                        Text("Entry Time: "+ DateFormat('MMM-dd-yy : HH:mm').format(_parkingHistory[index]['entry_time'].toDate())),
                        Text(
                          _parkingHistory[index]['exit_time'] != null ?
                            "Exit Time: "+ DateFormat('MMM-dd-yy : HH:mm').format(_parkingHistory[index]['exit_time'].toDate())
                              : "Exit Time: null"
                        ),
                        Text("Entry Time: "+ _parkingHistory[index]['status']),
                      ],
                    ),
                  )
                  :
                    Text("No data found");
                },
              ),
            ),

          ],
        ),
      ),

    );
  }
}
