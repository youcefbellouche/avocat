import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class User {
  String? uid;
  String? avatarImg;
  String? nom;
  String? prenom;
  String? numero;
  String? email;
  String? wilaya;
  String? type;
  User(
      {this.uid,
      this.avatarImg,
      this.nom,
      this.prenom,
      this.numero,
      this.email,
      this.wilaya,
      this.type});
  User.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    avatarImg = json["avatarImg"];
    nom = json["nom"];
    prenom = json["prenom"];
    numero = json["tel"];
    email = json["email"];
    type = json["type"];
  }

  Future<bool> validatePassword(String pass) async {
    var firebaseUser = FirebaseAuth.instance.currentUser!;
    var credential = EmailAuthProvider.credential(
        email: firebaseUser.email!, password: pass);
    try {
      var result = await firebaseUser.reauthenticateWithCredential(credential);
      return result.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void updateUserPassword(
      {required String newPass, required String oldPass}) async {
    await validatePassword(oldPass).then((value) {
      if (value) {
        var firebaseuser = FirebaseAuth.instance.currentUser!;
        firebaseuser.updatePassword(newPass).catchError((e) {
          Get.snackbar("خطأ", "يوجد خلل في الإنترنت",
              colorText: Colors.white,
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM);
        }).whenComplete(() {
          Get.back();
          Get.snackbar("تم", "تم تغيير كلمة المرور بنجاح",
              colorText: Colors.white,
              backgroundColor: Colors.green,
              snackPosition: SnackPosition.BOTTOM);
        });
      } else {
        Get.snackbar("خطأ", "كلمة المرور خاطئة",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
      }
    }).catchError((e) {
      Get.snackbar("خطأ", "يوجد خلل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
