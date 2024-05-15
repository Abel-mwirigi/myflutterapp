import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/UserController.dart';
import 'package:flutter_application_1/views/customtext.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/views/customButton.dart';
import 'package:flutter_application_1/views/registration.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showCheckIcon = false;
  bool isPasswordVisible = false; // Track if password visibility is on or off
  String errorMessage = '';

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();

    // Add a listener to the emailController
    emailController.addListener(() {
      setState(() {
        // Check if the email ends with ".gmail.com"
        showCheckIcon = emailController.text.endsWith('@gmail.com');
      });
    });
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffB81736), Color(0xff281537)],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: CustomText(
                label: 'Hello\nLogin!',
                fontSize: 30,
                labelColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          suffixIcon: showCheckIcon
                              ? Icon(
                                  Icons.check,
                                  color: Colors.grey,
                                )
                              : null,
                          labelText: 'Gmail',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText:
                            !isPasswordVisible, // Toggle password visibility
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          label: 'Forgot Password?',
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          labelColor: Color(0xff281537),
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [Color(0xffB81736), Color(0xff281537)],
                          ),
                        ),
                        child: CustomButton(
                          label: 'Log In',
                          onPressed: login,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              label: "Don't have account?",
                              fontWeight: FontWeight.bold,
                              labelColor: Colors.grey,
                            ),
                            CustomButton(
                              label: 'Sign Up',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegScreen()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (errorMessage.isNotEmpty)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void login() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    print('Here is the $email');
    print(password);
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    String jsonData = jsonEncode(data);

    Uri apiUrl = Uri.parse('http://127.0.0.1:8000/user/login/');

    try {
      final http.Response response = await http.post(
        apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print(response.body);
        userController.updateUser(User.fromJson(jsonDecode(response.body)));

        navigateToDashboard();
      } else {
        print('Failed to login');
        print(response.statusCode);
        print(response.body);
        setState(() {
          errorMessage = 'Incorrect email or password'; // Set error message
        });
      }
    } catch (e) {
      print('Failed to connect to the server');
      setState(() {
        errorMessage = 'Failed to connect to the server'; // Set error message
      });
    }
  }

  void navigateToDashboard() {
    Get.toNamed("/home");
  }
}
