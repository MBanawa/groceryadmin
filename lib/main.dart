import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:groceryadmin/screens/validate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValidateScreen(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.green,
          primaryColor: Colors.green),
    );
  }
}
