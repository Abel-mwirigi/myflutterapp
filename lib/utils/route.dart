import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:get/get.dart';

class Routes {
  static var routes = [
    GetPage(
      name: '/',
      page: () => Home(),
    ),
    GetPage(
      name: '/home',
      page: () => Dashboard(),
    ),
  ];
}
