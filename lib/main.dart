import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/UserController.dart';
import 'package:flutter_application_1/utils/route.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  Get.put(UserController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes,
  ));
}