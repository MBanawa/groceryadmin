import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageCategoryScreen extends StatelessWidget {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _titleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Category"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Category Name",
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
                child: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  _db
                      .collection("categoreis")
                      .add({"title": _titleCtrl.text}).then((value) {
                    Get.back();
                  }).catchError((e) {
                    print(e);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
