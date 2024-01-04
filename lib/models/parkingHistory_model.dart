import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingHistoryModel {
  final Timestamp entryTime;
  final Timestamp exitTime;
  final String status;

  ParkingHistoryModel({required this.entryTime, required this.exitTime, required this.status});

  factory ParkingHistoryModel.fromMap(Map<String, dynamic> map) {
    return ParkingHistoryModel(
      entryTime: map['entry_time'],
      exitTime: map['exit_time'],
      status: map['status'],
      // Map other fields as needed
    );
  }
}
