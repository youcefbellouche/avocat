import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/Widget/Field.dart';
import '../../Controller/ForgetPasswordController.dart';
import '../../constant.dart';

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      builder: (c) => c.loading.value
          ? Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Scaffold(
                body: Container(
                  color: primaryColor,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: primaryColor,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "هل نسيت كلمة المرور ؟",
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60)),
                            ),
                            child: Form(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Text(
                                    "البريد الإلكتروني للحساب الخاص بك",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomField(
                                    read: false,
                                    controller: emailController,
                                    label: "البريد الإلكتروني",
                                    mdp: false,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Abutton(
                                    size: Size(155, 50),
                                    colors: primaryColor,
                                    child: Text(
                                      'إرسال طلب',
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    onpressed: () async {
                                      if (!emailController.text.contains("@") ||
                                          !emailController.text.contains(".") ||
                                          emailController.text.isEmpty) {
                                        print(emailController.text);
                                        Get.snackbar("خطأ",
                                            "البريد الإلكتروني الذي أدخلتموه خاطئ",
                                            colorText: Colors.white,
                                            backgroundColor: Colors.redAccent,
                                            snackPosition:
                                                SnackPosition.BOTTOM);
                                        return;
                                      }
                                      c.load();
                                      if (await passwordReset(
                                          context: context,
                                          email: emailController.text))
                                        c.load();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<bool> passwordReset(
      {required BuildContext context, required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((v) {
      Get.offAndToNamed("/home");
      Get.snackbar("تم", "تم إرسال الطلب بنجاح ",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((e) {
      if (e.toString().contains(
          "There is no user record corresponding to this identifier")) {
        Get.snackbar("خطأ", "لا يوجد مستخدم بهذا البريد الإلكتروني ",
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
            snackPosition: SnackPosition.BOTTOM);
      }
      Get.snackbar("خطأ", "بوجد خلل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    });
    return true;
  }
}
