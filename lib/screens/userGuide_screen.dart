import 'package:flutter/material.dart';
class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("User Guide"),
        centerTitle: true,
        backgroundColor: Color(0xFFADD8E6),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        height: size.height,
        width: size.width,
        color: Color(0xFFADD8E6),
        child: Column(
          children: [
            Text("• Orange marker represents fully occupied parking space"),
            Text("• Green marker represents parking spaces with freee parking slots"),
            Text("• Red marker represents your current position"),
          ],
        ),
      ),
    );
  }
}
