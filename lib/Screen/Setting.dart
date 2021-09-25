import 'package:avocat/Controller/FromController.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/Widget/Field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FromController>(
        init: FromController(),
        builder: (c) => Scaffold(
              backgroundColor: Colors.grey[200],
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: FaIcon(
                        FontAwesomeIcons.user,
                        color: Colors.black,
                        size: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black38, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () => Get.toNamed('/profile'),
                      horizontalTitleGap: 0.0,
                      title: Text(
                        'الملف الشخصي',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: FaIcon(
                        FontAwesomeIcons.lock,
                        color: Colors.black,
                        size: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black38, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        c.load();
                        mdpEdit(context);
                        c.load();
                      },
                      horizontalTitleGap: 0.0,
                      title: Text(
                        'تغيير كلمة المرور',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: FaIcon(
                        FontAwesomeIcons.infoCircle,
                        color: Colors.black,
                        size: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black38, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {},
                      horizontalTitleGap: 0.0,
                      title: Text(
                        'معلومات عنا',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: FaIcon(
                        FontAwesomeIcons.tabletAlt,
                        color: Colors.black,
                        size: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black38, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        openLink("https://raysel-revolution.com");
                      },
                      horizontalTitleGap: 0.0,
                      title: Text(
                        'مطوري التطبيق',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: FaIcon(
                        FontAwesomeIcons.signOutAlt,
                        color: Colors.black,
                        size: 16,
                      ),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.black38, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(12)),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Get.offAllNamed('/login');
                      },
                      horizontalTitleGap: 0.0,
                      title: Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  void updateUserPassword(
      {required String newPass, required String oldPass}) async {
    var valide = await validateCurrentPassword(oldPass);
    if (valide == false) {
      Get.snackbar('خطأ', ' كلمة المرور خاطئ',
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(defaultPadding));
      return;
    }
    var firebaseuser = FirebaseAuth.instance.currentUser!;
    firebaseuser.updatePassword(newPass);
    Get.back();
    Get.snackbar('كلمة المرور', 'تغيير كلمة المرور بنجاح',
        colorText: Colors.white,
        backgroundColor: primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(defaultPadding));
  }

  Future<bool> validateCurrentPassword(String pass) async {
    return await validatePassword(pass);
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

  Future openLink(
    String url,
  ) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<dynamic> mdpEdit(BuildContext context) {
    TextEditingController oldpass = new TextEditingController();
    TextEditingController newpass = new TextEditingController();
    TextEditingController newCpass = new TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            title: Text(
              'رقم الهاتف',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
            ),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 450,
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomField(
                          validator: (input) => input!.isEmpty
                              ? "يرجى ملء كلمة المرور القديمة"
                              : null,
                          mdp: true,
                          controller: oldpass,
                          read: false,
                          label: 'كلمة المرور القديمة',
                        ),
                        CustomField(
                          validator: (input) => input!.isEmpty
                              ? "يرجى ملء كلمة المرور جديدة"
                              : null,
                          mdp: true,
                          controller: newpass,
                          read: false,
                          label: 'كلمة مرور جديدة',
                        ),
                        CustomField(
                          validator: (input) => input!.isEmpty
                              ? "يرجى ملء كلمة المرور جديدة"
                              : null,
                          mdp: true,
                          controller: newCpass,
                          read: false,
                          label: 'تحقق من كلمة المرور الجديدة',
                        ),
                        Abutton(
                          size: Size(155, 30),
                          colors: primaryColor,
                          child: Text(
                            'تحديث',
                            style: TextStyle(color: Colors.white),
                          ),
                          onpressed: () {
                            if (formKey.currentState!.validate()) {
                              if (newpass.text == newCpass.text) {
                                updateUserPassword(
                                    newPass: newpass.text,
                                    oldPass: oldpass.text);
                              } else {
                                Get.snackbar("خطأ",
                                    "كلمة المرور الجديدة وتأكيد كلمة المرور غير متطابقين",
                                    colorText: Colors.white,
                                    backgroundColor: Colors.redAccent,
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            }
                          },
                        ),
                        Abutton(
                          size: Size(155, 30),
                          colors: secondaryColor,
                          child: Text(
                            'إلغاء',
                            style: TextStyle(color: Colors.white),
                          ),
                          onpressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
