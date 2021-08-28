import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Controller/LoginController.dart';
import 'package:avocat/Screen/Auth/ForgetPassword.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/Widget/Field.dart';
import 'package:avocat/constant.dart';

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
              ? Center(
                  child: CircularProgressIndicator(),
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
                                  Text(
                                    'أهلا بكم في',
                                    style: TextStyle(
                                        fontFamily: 'samt',
                                        color: secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
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
                                SizedBox(height: 30),
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
                                TextButton(
                                    onPressed: () {
                                      Get.to(ForgetPassword());
                                    },
                                    child: Text(
                                      "هل نسيت كلمة المرور ؟",
                                      style: TextStyle(color: secondaryColor),
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
}
