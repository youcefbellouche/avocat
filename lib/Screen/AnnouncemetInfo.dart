import 'package:accordion/accordion.dart';
import 'package:avocat/Controller/FromController.dart';
import 'package:avocat/Models/Announcement.dart';
import 'package:avocat/Models/User.dart';
import 'package:avocat/Widget/Button.dart';
import 'package:avocat/Widget/Field.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fuser;
import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant.dart';

// ignore: must_be_immutable
class AnnouncemetInfo extends StatelessWidget {
  bool me;
  AnnouncemetInfo({required this.announcement, required this.me, Key? key})
      : super(key: key);

  Announcement announcement;
  TextEditingController repController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  int? index;
  String? myRep;

  @override
  Widget build(BuildContext context) {
    if (me) {
      index = announcement.avocat!
          .indexOf(fauth.FirebaseAuth.instance.currentUser!.uid);
      myRep = announcement.answer![index!];
    }
    return GetBuilder<FromController>(
        init: FromController(),
        builder: (c) => Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                iconTheme: IconThemeData(color: bgColor),
                title: Text(
                  'التفاصيل استشارة',
                  style: TextStyle(fontWeight: FontWeight.bold, color: bgColor),
                ),
              ),
              body: c.loading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Accordion(
                            contentBackgroundColor:
                                secondaryColor.withOpacity(0.05),
                            contentBorderRadius: 8,
                            contentBorderColor: primaryColor,
                            contentBorderWidth: 1,
                            maxOpenSections: 3,
                            children: [
                              AccordionSection(
                                isOpen: true,
                                header: Text('استشارة',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('رقم استشارة : ${announcement.id}'),
                                    SizedBox(height: 5),
                                    Text(
                                      'تاريخ :  ${announcement.date!.year}/${announcement.date!.month}/${announcement.date!.day}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'الحالة :  ${announcement.statusText}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              AccordionSection(
                                header: Text('سؤال',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                                content: Text(
                                  'استشارة :  ${announcement.content!}',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              ),
                              AccordionSection(
                                isOpen: true,
                                header: Text('إجاب',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                                content: me
                                    ? Column(
                                        children: [
                                          Text(
                                            'جوابي',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            myRep!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )
                                    : sendAnswer(c),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ));
  }

  Widget sendAnswer(FromController c) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomField(
            controller: repController,
            validator: (input) {
              if (input == null) {
                return "قدم إجاب";
              } else {
                return null;
              }
            },
            read: false,
            label: 'إجاب',
          ),
          Abutton(
            onpressed: () async {
              if (formKey.currentState!.validate()) {
                c.load();
                if (announcement.avocat == null) {
                  await fuser.FirebaseFirestore.instance
                      .collection("Announcement")
                      .doc(announcement.id.toString())
                      .update({
                    'avocat': fuser.FieldValue.arrayUnion(
                        [fauth.FirebaseAuth.instance.currentUser!.uid]),
                    'answer': fuser.FieldValue.arrayUnion([repController.text]),
                  }).whenComplete(() {
                    c.load();

                    Get.back();
                  });
                } else {
                  if (announcement.avocat!.length < 2) {
                    await fuser.FirebaseFirestore.instance
                        .collection("Announcement")
                        .doc(announcement.id.toString())
                        .update({
                      'avocat': fuser.FieldValue.arrayUnion(
                          [fauth.FirebaseAuth.instance.currentUser!.uid]),
                      'answer':
                          fuser.FieldValue.arrayUnion([repController.text]),
                    }).whenComplete(() {
                      c.load();

                      Get.back();
                    });
                  } else {
                    await fuser.FirebaseFirestore.instance
                        .collection("Announcement")
                        .doc(announcement.id.toString())
                        .update({
                      'avocat': fuser.FieldValue.arrayUnion(
                          [fauth.FirebaseAuth.instance.currentUser!.uid]),
                      'answer':
                          fuser.FieldValue.arrayUnion([repController.text]),
                      'status': 'finish'
                    }).whenComplete(() {
                      c.load();

                      Get.back();
                    });
                  }
                }
              }
            },
            size: Size(155, 30),
            colors: Colors.green,
            child: Text(
              'إرسال الاستجابة',
              style: TextStyle(color: bgColor),
            ),
          )
        ],
      ),
    );
  }

  Widget avocatInfo(id) {
    return FutureBuilder<fuser.DocumentSnapshot>(
        future: fuser.FirebaseFirestore.instance
            .collection('Avocats')
            .doc(id)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User avocat =
                User.fromJson(snapshot.data!.data() as Map<String, dynamic>);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('اللقب :'),
                Text(avocat.nom!),
                Text('الإسم :'),
                Text(avocat.prenom!),
                Text('بريد الإلكتروني :'),
                Text(avocat.email!),
                Text('رقم الهاتف :'),
                Text(avocat.numero!),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
        });
  }
}
