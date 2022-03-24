import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryadmin/screens/login.dart';
import 'package:groceryadmin/screens/tabs.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isUserLoggedin = false.obs;

  @override
  void onInit() {
    super.onInit();
    validate();
  }

  validate() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        isUserLoggedin.value = true;
      } else {
        isUserLoggedin.value = false;
      }
    });
  }

  login(email, password) {
    email = (email).trim().toLowerCase();
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((res) {
      Get.offAll(TabsScreen());
    }).catchError((e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 3),
        message: "Login Error: ${e.toString()}",
      ));
    });
  }

  logout() {
    _auth.signOut().then((res) {
      Get.offAll(LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }
}
