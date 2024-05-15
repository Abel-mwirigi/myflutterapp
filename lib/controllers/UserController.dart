import 'package:flutter_application_1/models/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // User object
  User? user;

  // Constructor
  UserController({this.user});

  // Get user information
  User? getUser() {
    return user;
  }

  // Update user information
  void updateUser(User newUser) {
    user = newUser;
  }

  // Logout user
  void logout() {
    user = null;
  }
}
