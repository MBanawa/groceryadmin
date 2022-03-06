import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryadmin/screens/login.dart';
import 'package:groceryadmin/screens/tabs.dart';

class ValidateScreen extends StatefulWidget {
  const ValidateScreen({Key? key}) : super(key: key);

  @override
  State<ValidateScreen> createState() => _ValidateScreenState();
}

class _ValidateScreenState extends State<ValidateScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedin = false;

  validate() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          _isLoggedin = true;
        });
      } else {
        setState(() {
          _isLoggedin = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    validate();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedin ? TabsScreen() : LoginScreen();
  }
}
