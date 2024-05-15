import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/registration.dart';
import 'package:flutter_application_1/views/transactionpost.dart';
import 'package:get/get.dart';

class Routes {
  static var routes = [
    //GetPage(name: "/", page: () => LoginScreen()),
    GetPage(name: "/", page: () => RegScreen()),
    GetPage(
      name: '/home',
      page: () => Home(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => Dashboard(),
    ),
    GetPage(
      name: '/statistics',
      page: () => ProfilePage(),
    ),
  ];
}
