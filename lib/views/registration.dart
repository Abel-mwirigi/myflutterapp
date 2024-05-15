import 'dart:convert';
import 'package:flutter_application_1/controllers/UserController.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/views/customtext.dart';
import 'package:flutter_application_1/views/customtextField.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/customButton.dart';
import 'package:flutter_application_1/views/loginscreen.dart';

class RegScreen extends StatefulWidget {
  RegScreen({Key? key}) : super(key: key);

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final UserController userController = Get.find<UserController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool showCheckIcon = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  final form = GlobalKey<FormState>();

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
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Form(
              key: form,
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
                        CustomTextField(
                          Controller: usernameController,
                          hintText: 'Username',
                          decoration: const InputDecoration(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          Controller: emailController,
                          hintText: 'Email',
                          decoration: InputDecoration(
                            suffixIcon: showCheckIcon
                                ? Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  )
                                : null,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          Controller: passwordController,
                          hintText: 'Password',
                          obscureText: !isPasswordVisible,
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
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          Controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: !isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isConfirmPasswordVisible =
                                      !isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value != passwordController.text) {
                              return 'Password does not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
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
                            label: 'SIGN UP',
                            onPressed: () {
                              signup();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                label: "Already have an account?",
                                fontWeight: FontWeight.bold,
                                labelColor: Colors.grey,
                              ),
                              CustomButton(
                                label: 'Sign in',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
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
          ),
        ],
      ),
    );
  }

  void signup() async {
    if (form.currentState!.validate()) {
      final String username = usernameController.text;
      final String email = emailController.text;
      final String password = passwordController.text;

      Map<String, dynamic> data = {
        'username': username,
        'email': email,
        'password': password,
      };

      String jsonData = jsonEncode(data);

      Uri apiUrl = Uri.parse('http://127.0.0.1:8000/user/signup/');

      try {
        final response = await http.post(
          apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        if (response.statusCode == 201) {
          userController.updateUser(User.fromJson(jsonDecode(response.body)));
          navigateToSomewhere();
        } else {
          print('Failed to create user');
        }
      } catch (e) {
        print('Failed to connect to the server');
      }
    }
  }

  void navigateToSomewhere() {
    Get.toNamed("/home");
  }
}
