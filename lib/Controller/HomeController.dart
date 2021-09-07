import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../Rev_push_notification.dart';

class HomeController extends GetxController {
  RxInt selectedWidget = 1.obs;

  void fcml() async {
    Rev_PushNotification.onMessage
        .listen(Rev_PushNotification.invokeLocalNotification);
    Rev_PushNotification.onMessageOpenedApp.listen(_pageOpen);
  }

  _pageOpen(RemoteMessage remote) {
    final Map<String, dynamic> mes = remote.data;
    onSelectedNotification(jsonEncode(mes));
  }

  Future onSelectedNotification(String? payload) async {
    print(payload);
  }

  @override
  void onInit() {
    Rev_PushNotification.initialize(onSelectedNotification)
        .then((value) => fcml());
    super.onInit();
  }

  change(int value) {
    selectedWidget = value.obs;
    update();
  }
}
