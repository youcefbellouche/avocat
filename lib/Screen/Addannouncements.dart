import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Controller/FromController.dart';
import 'package:avocat/Models/Announcement.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/constant.dart';

// ignore: must_be_immutable
class Addannouncements extends StatelessWidget {
  Addannouncements({Key? key}) : super(key: key);

  TextEditingController controller = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  Announcement announcement = new Announcement();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FromController>(
        init: FromController(),
        builder: (c) => Container(
              height: 280,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                child: Container(
                  color: bgColor,
                  child: !c.loading.value
                      ? Column(
                          children: [
                            field(),
                            SizedBox(height: 12),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Abutton(
                                    size: Size(155, 30),
                                    colors: secondaryColor,
                                    child: Text(
                                      'إلغاء',
                                      style: TextStyle(color: bgColor),
                                    ),
                                    onpressed: () {
                                      controller.clear();
                                      Get.back();
                                    },
                                  ),
                                  Abutton(
                                    size: Size(155, 30),
                                    colors: primaryColor,
                                    child: Text(
                                      'إرسال',
                                      style: TextStyle(color: bgColor),
                                    ),
                                    onpressed: () {
                                      if (formKey.currentState!.validate()) {
                                        c.load();
                                        announcement.content = controller.text;
                                        announcement.uid = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        announcement.id = DateTime.now()
                                            .millisecondsSinceEpoch;
                                        announcement.status = 'novalid';
                                        announcement.add();
                                        c.load();
                                        Get.back();
                                        Get.snackbar('إضافة استشارة',
                                            'إضافة استشارة ناجحة',
                                            colorText: Colors.white,
                                            backgroundColor: primaryColor,
                                            snackPosition: SnackPosition.BOTTOM,
                                            margin:
                                                EdgeInsets.all(defaultPadding));
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: secondaryColor,
                          ),
                        ),
                ),
              ),
            ));
  }

  Container field() {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 12, right: 12),
      padding: EdgeInsets.all(12),
      child: SizedBox(
        height: 140,
        child: Form(
          key: formKey,
          child: TextFormField(
            validator: (input) {
              if (input == null || input.length == 0) {
                return "قدم استشارة";
              }
              if (input.length > 500) {
                return "استشارة يجب ألا تجاوز 500 حرف";
              }

              return null;
            },
            controller: controller,
            maxLines: 5,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: secondaryColor,
              ),
              hintText: ' استشارة',
              labelText: 'إضافة استشارة',
              errorStyle: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(24)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondaryColor, width: 1),
                  borderRadius: BorderRadius.circular(24)),
              disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(24)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(24)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: secondaryColor, width: 1),
                  borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ),
      ),
    );
  }
}
