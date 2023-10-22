
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkmandu/repository/exceptions/signup_email_password_failure.dart';
import 'package:parkmandu/screens/homepage.dart';


import '../Screens/signin.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();
  
  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => SignIn()) : Get.offAll(() => const HomePage());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(() => const HomePage()) : Get.to(() => SignIn());
    } on FirebaseAuthException catch(e){
      final ex = SignUpEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXCEPTION - ${ex.message}');
      throw ex;
    } catch (e){
      const ex = SignUpEmailAndPasswordFailure();
      throw ex;
    }
  }

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      /*if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }*/
      Get.snackbar("about Login", "Login message",
      backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Login failed"
        ),
        messageText: Text(e.toString(),)
      );

    } catch (_){}
  }

  //Google Authentication
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }on FirebaseAuthException catch(e){
      throw Exception(e.message);
    }

  }

  Future<void> logout() async => await _auth.signOut();
}