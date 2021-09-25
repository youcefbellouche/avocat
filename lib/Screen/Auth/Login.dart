import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Controller/LoginController.dart';
import 'package:avocat/Screen/Auth/ForgetPassword.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/Widget/Field.dart';
import 'package:avocat/constant.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController mdpcontroller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (c) => SafeArea(
        child: Scaffold(
          body: c.loading.value
              ? Container(
                  color: primaryColor,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(
                  color: primaryColor,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: Image.asset(
                                        'assets/image/logo-dore.png',
                                      )),
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
                            key: formKey,
                            child: ListView(
                              children: [
                                SizedBox(height: 30),
                                CustomField(
                                  validator: (input) => input!.isEmpty
                                      ? "يرجى ملء البريد الإلكتروني"
                                      : null,
                                  read: false,
                                  controller: emailcontroller,
                                  label: 'البريد الإلكتروني',
                                ),
                                CustomField(
                                  validator: (input) => input!.isEmpty
                                      ? "يرجى ملء كلمة المرور"
                                      : null,
                                  mdp: true,
                                  read: false,
                                  controller: mdpcontroller,
                                  label: 'كلمة المرور',
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(ForgetPassword());
                                    },
                                    child: Text(
                                      "هل نسيت كلمة المرور ؟",
                                      style: TextStyle(color: secondaryColor),
                                    )),
                                const SizedBox(height: 30),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 50),
                                  child: Abutton(
                                    size: Size(155, 50),
                                    colors: primaryColor,
                                    child: Text(
                                      'تسجيل الدخول',
                                      style: TextStyle(
                                          color: secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    onpressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        print(emailcontroller.text +
                                            "  " +
                                            mdpcontroller.text);
                                        c.load();

                                        await c.login(emailcontroller.text,
                                            mdpcontroller.text, context);
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                    onPressed: () => notNowPopup(),
                                    child: Text(
                                      "التسجيل كمستشار",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )),
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
    );
  }

  Future<dynamic> notNowPopup() {
    return Get.defaultDialog(
      confirm: Container(),
      cancelTextColor: secondaryColor,
      buttonColor: secondaryColor,
      textCancel: 'حسنا',
      onConfirm: () => Get.back(),
      title: 'التسجيل',
      titleStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
      middleText: "يرجى التواصل مع إدارة التطبيق",
      content: Column(
        children: [
          Text(
            'يمكنك الاتصال بنا عبر البريد الإلكتروني',
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () => openEmail(),
            child: Text('avocat.enligne.dz@gmail.com',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                )),
          ),
          Text(
            ' أو على صفحتنا على الفيسبوك',
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: () => openLink('https://www.facebook.com/avocat.enligne.dz'),
            child: Text('https://www.facebook.com/avocat.enligne.dz',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                )),
          ),
        ],
      ),
      middleTextStyle: TextStyle(color: primaryColor),
    );
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

  Future openEmail() async {
    await launch("mailto:avocat.enligne.dz@gmail.com?subject=ISTICHARATY")
        .catchError((e) {
      Get.snackbar("خطأ", "بوجد خلل في الإنترنت",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM);
    });
  }
}
