import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:avocat/Controller/UserController.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/Widget/Field.dart';
import 'package:get/get.dart';
import 'package:avocat/constant.dart';

// ignore: must_be_immutable
class Profile extends StatelessWidget {
  UserController user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (c) {
          c.getUser();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              iconTheme: IconThemeData(color: bgColor),
              title: Text(
                'الملف الشخصي',
                style: TextStyle(fontWeight: FontWeight.bold, color: bgColor),
              ),
            ),
            body: c.loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff204575),
                    ),
                  )
                : SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(bottom: 24, top: 12),
                      child: Column(
                        children: [
                          CustomField(
                            read: true,
                            value: c.user.nom,
                            label: 'اللقب',
                          ),
                          CustomField(
                            read: true,
                            value: c.user.prenom,
                            label: 'الإسم',
                          ),
                          CustomField(
                            read: true,
                            value: c.user.email,
                            label: 'بريد الإلكتروني',
                          ),
                          CustomField(
                            suffix: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.edit,
                                color: secondaryColor,
                              ),
                              onPressed: () async {
                                await telEdit(context);
                              },
                            ),
                            read: true,
                            controller:
                                TextEditingController(text: c.user.numero),
                            label: 'رقم الهاتف',
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }

  Future<dynamic> telEdit(BuildContext context) {
    TextEditingController telcontroller = new TextEditingController();
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            title: Text(
              'رقم الهاتف',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
            ),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Center(
                  child: Column(
                    children: [
                      CustomField(
                        read: true,
                        value: user.user.numero,
                        label: 'رقم الهاتف القديم',
                      ),
                      CustomField(
                        controller: telcontroller,
                        read: false,
                        textInputType: TextInputType.phone,
                        label: 'رقم هاتف جديد',
                      ),
                      Abutton(
                        size: Size(155, 30),
                        colors: primaryColor,
                        child: Text(
                          'تحديث',
                          style: TextStyle(color: Colors.white),
                        ),
                        onpressed: () {
                          if (!telcontroller.text.startsWith('0') ||
                              telcontroller.text.length != 10 ||
                              telcontroller.text.contains(" ")) {
                            Get.snackbar("خطأ", "الرقم الذي أدخلتموه خاطئ",
                                colorText: Colors.white,
                                backgroundColor: Colors.redAccent,
                                snackPosition: SnackPosition.BOTTOM);
                            return;
                          }
                          user.updatePhone(telcontroller.text);
                          Get.back();
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
            ],
          );
        });
  }
}
