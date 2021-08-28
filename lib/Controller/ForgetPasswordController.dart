import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  RxBool loading = false.obs;

  load() {
    if (loading.isFalse) {
      loading = true.obs;
    } else {
      loading = false.obs;
    }

    update();
  }
}
