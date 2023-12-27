import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpandedBottomSheet extends StatelessWidget {
  QuerySnapshot snapshot;
  ExpandedBottomSheet({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Hello"
      ),
    );
  }
}
