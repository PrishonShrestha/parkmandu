import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/parkingHistory_model.dart';

class ParkingHistoryController {
  final CollectionReference _parkingHistory =
  FirebaseFirestore.instance.collection('parking_info').doc("79yuoUXhcRdMJ32F3yyp").collection('vehicle_details');

  Future<List<ParkingHistoryModel>> searchUsers(String rfidNumber) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('parking_info').doc("79yuoUXhcRdMJ32F3yyp").collection('vehicle_details')
        .where('userid', isEqualTo: rfidNumber)
        .get();

    return querySnapshot.docs
        .map((DocumentSnapshot document) => ParkingHistoryModel.fromMap(document.data() as Map<String, dynamic>))
        .toList();
  }
}