import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
        centerTitle: true,
        title: Text("About Us"),
        backgroundColor: Color(0xFFADD8E6),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        height: size.height,
        width: size.width,
        child: Text(
          "Parkmandu is an mobile application that displays the details information of parking spaces nearby your current location",
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
