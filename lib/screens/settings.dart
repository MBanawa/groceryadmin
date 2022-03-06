import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:groceryadmin/screens/profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/mike.png'),
              ),
              title: const Text("Mikeruu Pogi"),
              subtitle: const Text("1 Makisig Way, Elite Village, 2009"),
              trailing: TextButton(
                onPressed: () {
                  Get.to(ProfileScreen());
                },
                child: const Text("Edit"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications_active_outlined),
              title: Text("Notifications"),
              subtitle: Text("Manage Notifications"),
              trailing: Switch(
                onChanged: (i) {},
                value: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
