import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Container(
      color: Color(0xFFCEE3E2),
      child: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Image(
            image: AssetImage("assets/images/loading.gif"),
          ),
        ),
      ),
    );
  }
}
