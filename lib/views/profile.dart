import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/UserController.dart';
import 'package:flutter_application_1/views/customButton.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // User Information Section
         Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Center(
            child: CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
            ),
          ),
          ),
          ListTile(
            title: Text(userController.getUser()?.username ?? "User"),
            subtitle: Text(userController.getUser()?.email ?? "email"),
            trailing: Icon(Icons.edit),
            onTap: () {
              // Navigate to edit profile screen
            },
          ),
          //Divider(),


          // Logout Button
          CustomButton(
            label: "Logout",
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirm Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: [
                      CustomButton(
                        label: "Logout",
                        onPressed: () {
                          // Perform logout actions
                          // Example: Navigate to login screen
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                      CustomButton(
                        label: "Cancel",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}
