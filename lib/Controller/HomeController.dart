import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedWidget = 1.obs;

  change(int value) {
    selectedWidget = value.obs;
    update();
  }
}
