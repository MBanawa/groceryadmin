import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/controllers/auth.dart';
import 'package:groceryadmin/screens/login.dart';
import 'package:groceryadmin/screens/tabs.dart';

class ValidateScreen extends StatelessWidget {
  final AuthController _auth = Get.put(AuthController());

  ValidateScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _auth.isUserLoggedin.value ? TabsScreen() : LoginScreen(),
    );
  }
}
