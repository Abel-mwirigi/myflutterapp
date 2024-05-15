import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constants.dart';
import 'package:flutter_application_1/controllers/homeController.dart';
import 'package:flutter_application_1/views/dashboard.dart';
import 'package:flutter_application_1/views/expandable_fab.dart';
import 'package:flutter_application_1/views/profile.dart';
import 'package:flutter_application_1/views/statistics.dart';
import 'package:flutter_application_1/views/transactionpost.dart';
import 'package:get/get.dart';

HomeController homeController = Get.put(HomeController());

var screens = [
  Dashboard(),
  Statistics(),
  ProfilePage(),
  //TransactionForm(),
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
              Icons.bar_chart_outlined,
              color: appWhiteColor,
            ),
            Icon(
              Icons.person,
              color: appWhiteColor,
            ),
          ],
          onTap: (index) {
            homeController.updateSelectedPage(index);
          }),
      body: Obx(() => Center(
            child: screens[homeController.selectedpage.value],
          )),
          floatingActionButton: ExpandableFab(
        distance: 112,
        children: [
          ActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TransactionFormDialog();
                },
              );
              //homeController.updateSelectedPage(3);
              // Add your logic here
              print('Action 1 pressed');
            },
            icon: Icon(Icons.add),
          ),
          ActionButton(
            onPressed: () {
              homeController.updateSelectedPage(2);
              // Add your logic here
              print('Action 2 pressed');
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
