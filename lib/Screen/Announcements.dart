import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/constant.dart';

import 'Addannouncements.dart';

class Announcements extends StatelessWidget {
  const Announcements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'استشارة',
          style: TextStyle(
              fontFamily: 'samt',
              fontWeight: FontWeight.bold,
              color: bgColor,
              fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 24, top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Abutton(
                    size: Size(400, 100),
                    onpressed: () {
                      Get.bottomSheet(Addannouncements(),
                          barrierColor: primaryColor.withOpacity(0.15));
                    },
                    child: Text(
                      'إضافة استشارة',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor),
                    ),
                    colors: bgColor),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
                child: Abutton(
                    size: Size(400, 100),
                    onpressed: () => notNowPopup(),
                    child: Text(
                      'طلب استشارة شخصية',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    colors: bgColor),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Abutton(
                    size: Size(400, 100),
                    onpressed: () => notNowPopup(),
                    child: Text(
                      'طلب تحرير مذكرة جوابية',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    colors: bgColor),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
                child: Abutton(
                    size: Size(400, 100),
                    onpressed: () => notNowPopup(),
                    child: Text(
                      'طلب تحرير عريضة افتتاح دعوى',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    colors: bgColor),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, right: 12),
                child: Abutton(
                    size: Size(400, 100),
                    onpressed: () => notNowPopup(),
                    child: Text(
                      'طلب تحرير شكوى',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    colors: bgColor),
              ),
            ],
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
      title: 'معلومة',
      titleStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.w600),
      middleText: " هذه الخدمة غير متوفزة الآن",
      middleTextStyle: TextStyle(color: primaryColor),
    );
  }
}
