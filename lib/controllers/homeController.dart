import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedpage = 0.obs;
  updateSelectedPage(index) => selectedpage.value = index;
}
