import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkmandu/Screens/signin.dart';
import 'package:parkmandu/controllers/signup_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Positioned(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width*0.11, bottom: 10, top: 50),
                        child: RichText(
                          text: TextSpan(
                            text: "Register with Parkmandu",
                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Container(
                        height: 445,
                        width: size.width*0.85,
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: SizedBox(
                                height: 420,
                                width: size.width*0.85,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 3,
                                        )
                                      ]
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: controller.fullname_controller,
                                            decoration: InputDecoration(
                                                labelText: "Full name",
                                                labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                hintText: " eg. abcd efgh",
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green, width: 1),
                                                )
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)){
                                                return "Enter correct name";
                                              }else{
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          TextFormField(
                                            controller: controller.email_controller,
                                            decoration: InputDecoration(
                                                labelText: "Email address",
                                                labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                hintText: " eg. abcd@gmail.com",
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green, width: 1),
                                                )
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty || !RegExp(r'^[\w-\,]+@([\w-]+\.)+[\w]{2,4}').hasMatch(value!)){
                                                return "Enter correct email address";
                                              }else{
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          TextFormField(
                                            controller: controller.contact_controller,
                                            decoration: InputDecoration(
                                                labelText: "Contact number",
                                                labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                hintText: " eg. 9860123456",
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                                prefixText: "+977 ",
                                                prefixStyle: TextStyle(color: Colors.black,),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green, width: 1),
                                                )
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty || !RegExp(r'^[0-9]{10}').hasMatch(value!)){
                                                return "Enter correct contact number";
                                              }else{
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          TextFormField(
                                            controller: controller.password_controller,
                                            decoration: InputDecoration(
                                                labelText: "Create password",
                                                labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                                hintText: " must be atleast 8 characters",
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green, width: 1),
                                                )
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty || !RegExp(r'^.{8,20}').hasMatch(value!)){
                                                return "Password must be 8-20 characters";
                                              }else{
                                                return null;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 395,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 200,
                                  child: TextButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                        SignUpController.instance.registerUser(controller.email_controller.text.trim(), controller.password_controller.text.trim());
                                        final snackBar = SnackBar(content: Text('Creating account'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else{
                                        final errorMsg = SnackBar(content: Text('Failed to create an account'));
                                        ScaffoldMessenger.of(context).showSnackBar(errorMsg);
                                      }
                                    },
                                    child: Text("Create account", style: TextStyle(color: Colors.white, fontSize: 20),),
                                    style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF1B1F25),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> SignIn())
                              );

                            },
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            )
                        )
                      ],
                    )

                  ],
                ),
              ),
              Positioned(
                top: 30,
                left: 20,
                child: IconButton(
                  color: Colors.blue,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  iconSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

