import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginScreen(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.green,
          primaryColor: Colors.green),
    );
  }
}
