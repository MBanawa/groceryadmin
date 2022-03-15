import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({Key? key}) : super(key: key);

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  var _categories = [];
  var _selectedId = "Dduq5nSc8LZX9QDZnorj";
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
              radius: 60,
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Product Title",
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Price",
              ),
            ),
            SizedBox(height: 12),
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
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Description",
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.green,
                ),
                child: Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
