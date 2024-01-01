import 'package:flutter/material.dart';
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
            Center(
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
                icon: Image.asset("assets/images/googleIcon.png", height: 35, width: 35,),
                label: Text("Sign in with google"),
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

