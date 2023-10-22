import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkmandu/repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  //Contoller to get data from textfields
  final fullname_controller = TextEditingController();
  final email_controller = TextEditingController();
  final contact_controller = TextEditingController();
  final password_controller = TextEditingController();


  //call this function from Design
  void registerUser(String email, String password) async{
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

}