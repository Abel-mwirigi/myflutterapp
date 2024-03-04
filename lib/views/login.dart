import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/views/customButton.dart';
import 'package:flutter_application_1/views/customtext.dart';
import 'package:flutter_application_1/views/customtextField.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          label: "DU App",
          labelColor: appWhiteColor,
          fontSize: 28,
        ),
        backgroundColor: primaryColor,
        foregroundColor: appWhiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/crest-blue.png",
                height: 120.0,
                width: 120.0,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: CustomText(
                    label: "Login Screen",
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                  label: "Username",
                  labelColor: Colors.blue,
                ),
              ),
              CustomTextField(
                  Controller: usernameController,
                  hintText: "Enter your username",
                  prefixIcon: const Icon(Icons.person)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(label: "Password"),
              ),
              CustomTextField(
                Controller: passwordController,
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.visibility),
              ),
              const SizedBox(height: 20),
              CustomButton(
                label: "login",
                action: navigateToCalculator,
              )
              // MaterialButton(onPressed: ()=>Get.toNamed("/calculator"),
              // child: Text("Login"),
              // height: 50,
              // minWidth: 200,
              // color: primaryColor,)
            ]),
      ),
    );
  }

  void navigateToCalculator() {
    Get.toNamed("/home");
  }
}
