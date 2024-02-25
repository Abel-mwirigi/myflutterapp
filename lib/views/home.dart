import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/homeController.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:get/get.dart';

HomeController homeController = Get.put(HomeController());

var screens = [
  Dashboard(),
  Text("profile"),
  Text("settings"),
];

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.black,
          color: primaryColor,
          items: const [
            Icon(
              Icons.home,
              color: appWhiteColor,
            ),
            Icon(
              Icons.person,
              color: appWhiteColor,
            ),
            Icon(
              Icons.settings,
              color: appWhiteColor,
            ),
          ],
          onTap: (index) {
            homeController.updateSelectedPage(index);
          }),
      body: Obx(() => Center(
            child: screens[homeController.selectedpage.value],
          )),
    );
  }
}
