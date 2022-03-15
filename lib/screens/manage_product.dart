import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({Key? key}) : super(key: key);

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  var _categories = [];
  var _selectedId = "Dduq5nSc8LZX9QDZnorj";
  var imgURL = "https://picsum.photos/id/237/200/300";
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _desCtrl = TextEditingController();

  fetchCategories() {
    _db.collection("categories").snapshots().listen((event) {
      var _tmp = [];
      for (var element in event.docs) {
        _tmp.add({
          "id": element.id,
          "title": element.data()["title"],
        });
      }
      setState(() {
        _categories = _tmp;
      });
    });
  }

  add() {
    _db.collection("products").add({
      "title": _titleCtrl.text,
      "price": _priceCtrl.text,
      "categoryId": _selectedId,
      "desc": _desCtrl.text,
      "imageURL": imgURL,
    }).then((value) {
      Get.back();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  uploadImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile!.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      var filePath = (DateTime.now().millisecondsSinceEpoch).toString();

      _storage
          .ref()
          .child("products")
          .child(filePath)
          .putFile(image)
          .then((res) {
        print(res);
        res.ref.getDownloadURL().then((url) {
          setState(() {
            imgURL = url;
          });
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
        title: const Text("Manage Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgURL),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Product Title",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Price",
                ),
              ),
              const SizedBox(height: 12),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Category"),
                    DropdownButton(
                      value: _selectedId,
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          child: Text(category["title"]),
                          value: category["id"],
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedId = v.toString();
                        });
                      },
                    )
                  ],
                ),
              ),
              TextField(
                controller: _desCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Description",
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
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
                    add();
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
