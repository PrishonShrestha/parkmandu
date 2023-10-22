import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkmandu/Screens/signup.dart';
import 'package:parkmandu/controllers/signin_controller.dart';
import 'package:parkmandu/repository/authentication_repository.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final controller = Get.put(SignInController());
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();

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
                child: SizedBox(
                  height: size.height*0.56,
                  width: size.width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xFF01001C),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(400, 100), bottomRight: Radius.elliptical(400, 100))
                    ),
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
                            text: "Welcome!",
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: EdgeInsets.only(left: size.width*0.11, bottom: 50),
                        child: Container(
                          width: size.width*0.7,
                          child: Text(
                            "Let's find the best parking with us",
                            style: TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Container(
                        height: 270,
                        width: size.width*0.85,
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: SizedBox(
                                height: 240,
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
                                            controller: email_controller,
                                            decoration: InputDecoration(
                                                hintText: " Enter contact",
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green, width: 1),
                                                ),
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Can't be null";
                                              }else{
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: 10,),
                                          TextFormField(
                                            controller: password_controller,
                                            decoration: InputDecoration(
                                                hintText: " Enter password",
                                                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                                                focusedBorder: UnderlineInputBorder(
                                                  borderSide: BorderSide(color: Colors.green, width: 1),
                                                )
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Can't be null";
                                              }else{
                                                return null;
                                              }
                                            },
                                          ),
                                          SizedBox(height: 20,),
                                          Align(
                                            alignment: Alignment. centerRight,
                                            child: TextButton(
                                                onPressed: null,
                                                child: Text("Forgot password?", style: TextStyle(color: Colors.red, fontSize: 16),)
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 215,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width: 160,
                                  child: TextButton(
                                    onPressed: (){
                                      /*if(formKey.currentState!.validate()){
                                        SignInController.instance.signInUser(controller.email_controller.text.trim(), controller.password_controller.text.trim());
                                        final snackBar = SnackBar(content: Text('success'));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else{
                                        final errorMsg = SnackBar(content: Text('Failed'));
                                        ScaffoldMessenger.of(context).showSnackBar(errorMsg);
                                      }*/
                                      //AuthenticationRepository.instance.signinWithEmailAndPassword(email_controller.text.trim(), password_controller.text.trim());

                                      signIn(email_controller.text, password_controller.text);

                                    },
                                    child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 24),),
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Or continue with",
                      style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.add_a_photo_outlined),
                      iconSize: 40,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> SignUp())
                              );

                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            )
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

  }
  void signIn(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
        Get.snackbar("about Login", "Login message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
        "Login Success"
        ),
        messageText: Text("Success")
        )
        });
      } on FirebaseAuthException catch (error) {
        Get.snackbar("about Login", "Login message",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
                "Login failed"
            ),
            messageText: Text("Failed")
        );
        // print(error.code);
      }
    }
  }
}
