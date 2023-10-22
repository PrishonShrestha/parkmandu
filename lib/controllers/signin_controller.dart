import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkmandu/repository/authentication_repository.dart';

class SignInController extends GetxController{
  static SignInController get instance => Get.find();

  //Contoller to get data from textfields
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();

  final isGoogleLoading = false.obs;

  //Google Authentication
  Future<void> googleSignIn() async{
    try{
      isGoogleLoading.value = true;
      await AuthenticationRepository.instance.signInWithGoogle();
      isGoogleLoading.value = false;
    }catch(e){
      isGoogleLoading.value = false;
      print(e.toString());
    }
  }


  //call this function from Design
  void signInUser(String email, String password) async{
    AuthenticationRepository.instance.signinWithEmailAndPassword(email, password);
  }

}
