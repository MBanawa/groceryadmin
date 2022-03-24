import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var _profileImage = "https://picsum.photos/id/237/200/300";

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    readStoreDetail();
  }

  logout() {
    _auth.signOut().then((res) {
      Get.offAll(LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }

  readStoreDetail() {
    _db.collection("settings").doc("store").snapshots().listen((response) {
      _name.text = response.data()!["name"];
      _email.text = response.data()!["email"];
      _mobile.text = response.data()!["mobile"];
      _address.text = response.data()!["address"];
      _profileImage = response.data()!["imageURL"];
    });
  }

  updateStoreDetail() {
    _db.collection("settings").doc("store").update({
      "address": _address.text,
      "mobile": _mobile.text,
      "email": _email.text,
      "name": _name.text,
    }).then((value) {
      Get.back();
      print("Updated");
    }).catchError((e) {
      print(e);
    });
  }

  uploadProfileImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile!.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      _storage
          .ref()
          .child("store")
          .child("storeImage")
          .putFile(image)
          .then((res) {
        print(res);
        res.ref.getDownloadURL().then((url) {
          setState(() {
            _profileImage = url;
          });

          _db
              .collection("settings")
              .doc("store")
              .update({"imageURL": url}).then((value) {
            print("Updated");
          }).catchError((e) {
            print(e);
          });

          print("URL:" + url);
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("No file picked");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  uploadProfileImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profileImage),
                  radius: 60.0,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Name",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _mobile,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Mobile Number",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _address,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Address",
                ),
              ),
              const SizedBox(height: 12),
              // ignore: sized_box_for_whitespace
              Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Colors.green,
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    updateStoreDetail();
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  logout();
                  // Get.offAll(LoginScreen());
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
