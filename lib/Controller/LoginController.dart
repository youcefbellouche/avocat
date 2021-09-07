import 'package:firebase_auth/firebase_auth.dart' as fuser;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Models/User.dart';

import 'UserController.dart';

class LoginController extends GetxController {
  RxBool loading = false.obs;
  User? user = new User();

  load() {
    if (loading.isTrue) {
      loading = false.obs;
    } else {
      loading = true.obs;
    }
    update();
  }

  login(String email, String password, BuildContext context) async {
    print('log');
    UserController user = Get.put(UserController());
    await fuser.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      String message = e.message;
      loading = false.obs;
      update();
      if (message.contains("The service is currently unavailable") ||
          message.contains("A network error")) {
        Get.snackbar("خطأ", "بوجد خلل في الإنترنت",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("خطأ", "هناك خطأ في كلمة المرور أو البريد الإلكتروني",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
      }
    }).then((value) async {
      print(fuser.FirebaseAuth.instance.currentUser!.getIdToken());
      await user.getUser().whenComplete(() async {
        if (user.user.type != 'avocat') {
          fuser.FirebaseAuth.instance.signOut();
          Get.snackbar("خطأ", "هناك خطأ في كلمة المرور أو البريد الإلكتروني",
              colorText: Colors.white,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM);
        } else {
          try {
            FirebaseMessaging.instance.subscribeToTopic('avocatAnnonce');

            Get.offAndToNamed("/home");
          } catch (e) {
            fuser.FirebaseAuth.instance.signOut();
            Get.offAndToNamed("/login");
          }
        }
        loading = false.obs;
        update();
      });
    });
  }
}
