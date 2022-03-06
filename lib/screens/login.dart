import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/tabs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  login() {
    var email = (_email.text).trim().toLowerCase();
    var pass = _pass.text;
    _auth.signInWithEmailAndPassword(email: email, password: pass).then((res) {
      Get.offAll(TabsScreen());
    }).catchError((e) {
      Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 3),
        message: "Login Error: ${e.toString()}",
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 16),
              const Text(
                "Grocery Admin",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                obscureText: true,
                controller: _pass,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 16),
              // ignore: sized_box_for_whitespace
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: const Text("LOGIN"),
                  onPressed: () {
                    login();
                    // Get.offAll(TabsScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
