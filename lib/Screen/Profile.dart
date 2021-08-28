import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
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
                          CustomField(
                            suffix: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.edit,
                                color: secondaryColor,
                              ),
                              onPressed: () async {
                                await wilayaEdit(context);
                              },
                            ),
                            read: true,
                            controller:
                                TextEditingController(text: c.user.wilaya),
                            label: 'الولاية',
                          ),
                          Abutton(
                            size: Size(155, 30),
                            colors: primaryColor,
                            onpressed: () => mdpEdit(context),
                            child: Text(
                              'تغيير كلمة المرور',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
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

  Future<dynamic> wilayaEdit(BuildContext context) {
    TextEditingController wilayaController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            title: Text(
              'الولاية',
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
                        value: user.user.wilaya,
                        label: 'الولاية المسجلة مسبقا',
                      ),
                      CustomField(
                        controller: wilayaController,
                        read: false,
                        textInputType: TextInputType.phone,
                        label: 'الولاية جديدة',
                      ),
                      Abutton(
                        size: Size(155, 30),
                        colors: primaryColor,
                        child: Text(
                          'تحديث',
                          style: TextStyle(color: Colors.white),
                        ),
                        onpressed: () {
                          if (wilayaController.text.contains(" ")) {
                            Get.snackbar("خطأ", "يجب إدخال ولاية",
                                colorText: Colors.white,
                                backgroundColor: Colors.redAccent,
                                snackPosition: SnackPosition.BOTTOM);
                            return;
                          }
                          user.updateWilaya(wilayaController.text);
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

  Future<dynamic> mdpEdit(BuildContext context) {
    TextEditingController oldMdpController = new TextEditingController();
    TextEditingController newMdpController = new TextEditingController();
    TextEditingController newMdpCController = new TextEditingController();
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            title: Text(
              'كلمة السر',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: secondaryColor),
            ),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Center(
                  child: Expanded(
                    child: Column(
                      children: [
                        CustomField(
                          mdp: true,
                          controller: oldMdpController,
                          read: false,
                          textInputType: TextInputType.visiblePassword,
                          label: 'كلمة المرور المسجلة مسبقا',
                        ),
                        CustomField(
                          mdp: true,
                          controller: newMdpController,
                          read: false,
                          label: 'كلمة المرور الجديدة',
                        ),
                        CustomField(
                          mdp: true,
                          controller: newMdpCController,
                          read: false,
                          label: 'تأكيد كلمة المرور الجديدة',
                        ),
                        Abutton(
                          size: Size(155, 30),
                          colors: primaryColor,
                          child: Text(
                            'تحديث',
                            style: TextStyle(color: Colors.white),
                          ),
                          onpressed: () {
                            if (newMdpCController.text.isEmpty ||
                                newMdpController.text.isEmpty ||
                                oldMdpController.text.isEmpty) {
                              Get.snackbar("خطأ", "يجب ملء كل الفراغات",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.redAccent,
                                  snackPosition: SnackPosition.BOTTOM);
                              return;
                            }
                            if (newMdpCController.text !=
                                newMdpController.text) {
                              Get.snackbar("خطأ", "يجب تأكيد كلمة المرور",
                                  colorText: Colors.white,
                                  backgroundColor: Colors.redAccent,
                                  snackPosition: SnackPosition.BOTTOM);
                              return;
                            }
                            user.user.updateUserPassword(
                                newPass: newMdpCController.text,
                                oldPass: oldMdpController.text);
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
