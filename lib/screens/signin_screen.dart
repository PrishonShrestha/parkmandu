import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Color(0xFF68CDF0),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: size.height*0.6,
                  width: size.width,
                  color: Color(0xFF01001C),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text("Welcome!", style: GoogleFonts.prata(fontSize: 40, color: Colors.white))
                  ),
                  SizedBox(height: 10,),
                  Text("Let's find the best parking space \nwith us",  style: GoogleFonts.satisfy(fontSize: 23, color: Colors.white),),
                  SizedBox(height: 50,),
                  ElevatedButton.icon(
                    onPressed: (){
                      final provider = Provider.of<AuthController>(context, listen: false);
                      provider.signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width*0.7, 60),
                      backgroundColor: Color(0xFFF8F4E9),
                      textStyle: TextStyle(fontSize: 18),
                      foregroundColor: Colors.black,
                    ),
                    icon: Image.asset("assets/images/googleIcon.png", height: 35, width: 35,),
                    label: Text("Sign in with google"),
                  ),
                  SizedBox(height: 80,),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    /*Container(
      decoration: BoxDecoration(

      ),
      child: Center(
          child: ElevatedButton.icon(
            onPressed: (){
              final provider = Provider.of<AuthController>(context, listen: false);
              provider.signInWithGoogle();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width*0.7, 60),
              backgroundColor: Color(0xFFF8F4E9),
              textStyle: TextStyle(fontSize: 18),
              foregroundColor: Colors.black,
            ),
            icon: Icon(Icons.headphones),
            label: Text("Sign in with google"),
          )
      ),
    );*/
  }
}

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height-200);
    path.cubicTo(width*0.1, height+50, width * 0.7, height-200, width, height);
    //p.quadraticBezierTo(3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper)=> true;
}

