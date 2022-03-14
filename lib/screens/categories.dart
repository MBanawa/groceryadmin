import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/manage_category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List _categories = [
    "All",
    "Vegetables",
    "Meat",
    "Fruits",
    "Snacks",
    "Drinks",
    "Oils",
    "Daily Needs"
  ];

  fetchCategories() {
    _db.collection("categories");
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
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(ManageCategoryScreen());
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (bc, index) {
            return ListTile(
              title: Text("${_categories[index]}"),
              trailing: Icon(Icons.edit_outlined),
              onTap: () {
                Get.to(ManageCategoryScreen());
              },
            );
          },
        ),
      ),
    );
  }
}
