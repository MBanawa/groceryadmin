import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/manage_category.dart';

class CategoriesScreen extends StatelessWidget {
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
