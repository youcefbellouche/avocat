import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fUser;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Models/User.dart';

class UserController extends GetxController {
  User user = new User();
  bool loading = true;
  Future getUser() async {
    var result = await FirebaseFirestore.instance
        .collection("Avocats")
        .doc(fUser.FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (result.data() != null) user = User.fromJson(result.data()!);
    loading = false;
    update();
  }

  clear() {
    user = new User();
    update();
  }

  updatePhone(String phone) async {
    await FirebaseFirestore.instance.collection("avocat").doc(user.uid).update({
      "numero": phone,
    }).catchError((e) {
      Get.snackbar("خطأ", "بوجد مشكل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }).whenComplete(() {
      Get.snackbar("تم", "لقت قمت بتغيير رقم الهاتف بنجاح",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
      user.numero = phone;
      update();
    });
  }

  updateWilaya(String wilaya) async {
    await FirebaseFirestore.instance.collection("avocat").doc(user.uid).update({
      "wilaya": wilaya,
    }).catchError((e) {
      Get.snackbar("خطأ", "بوجد مشكل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }).whenComplete(() {
      Get.snackbar("تم", "لقت قمت بتغيير الولاية بنجاح",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
      user.wilaya = wilaya;
      update();
    });
  }

  updateDaira(String daira) async {
    await FirebaseFirestore.instance.collection("avocat").doc(user.uid).update({
      "daira": daira,
    }).catchError((e) {
      Get.snackbar("خطأ", "بوجد مشكل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }).whenComplete(() {
      Get.snackbar("تم", "لقت قمت بتغيير الدائرة بنجاح",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);

      update();
    });
  }

  updateMairie(String mairie) async {
    await FirebaseFirestore.instance.collection("avocat").doc(user.uid).update({
      "mairie": mairie,
    }).catchError((e) {
      Get.snackbar("خطأ", "بوجد مشكل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    }).whenComplete(() {
      Get.snackbar("تم", "لقت قمت بتغيير البلدية بنجاح",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);

      update();
    });
  }
}
