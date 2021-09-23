import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/Controller/HomeController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:avocat/Screen/setting.dart';
import 'package:avocat/constant.dart';

import 'Myannouncements.dart';

import 'Announcements.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static List<Widget> _widgetOptions = <Widget>[
    Myannouncements(),
    Announcements(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (c) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: primaryColor,
                title: Text(
                  'استشاراتي',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: bgColor,
                      fontFamily: 'samt',
                      fontSize: 30),
                ),
              ),
              drawer: Drawer(
                child: Container(
                  color: primaryColor,
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Image.asset(
                          'assets/image/logo-dore.png',
                        ),
                      ),
                      DrawerListTile(
                        title: "الحساب الشخصي",
                        icons: FontAwesomeIcons.userAlt,
                        press: () {
                          c.change(2);
                        },
                      ),
                      DrawerListTile(
                        title: "تسجيل الخروج",
                        icons: FontAwesomeIcons.signOutAlt,
                        press: () {
                          FirebaseAuth.instance.signOut();
                          Get.offAllNamed('/login');
                        },
                      ),
                      DrawerListTitle(title: 'خدمة الاستشارات القانونية'),
                      DrawerListTile(
                        icons: FontAwesomeIcons.plusSquare,
                        title: "الإجابة على الاستشارات",
                        press: () {
                          c.change(1);
                        },
                      ),
                      DrawerListTile(
                        icons: FontAwesomeIcons.listAlt,
                        title: "الإجابات السابقة",
                        press: () {
                          c.change(0);
                        },
                      ),
                      DrawerListTitle(title: 'خدمة الانابة قضائية'),
                      DrawerListTile(
                        icons: FontAwesomeIcons.plusSquare,
                        title: "انشاءانابة قضائية",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTile(
                        icons: FontAwesomeIcons.listAlt,
                        title: "متابعة الانابة القضائية",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTitle(title: 'تسيير مكتب المحامي'),
                      DrawerListTile(
                        icons: FontAwesomeIcons.plusSquare,
                        title: "تسجيل قضية",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTile(
                        icons: FontAwesomeIcons.plusSquare,
                        title: "تسجيل موكل جديد",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTitle(title: 'خدمات متنوعة'),
                      DrawerListTile(
                        icons: FontAwesomeIcons.bell,
                        title: "معلومات مفيدة",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTile(
                        icons: FontAwesomeIcons.gavel,
                        title: "مقالات قانونية",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTile(
                        icons: FontAwesomeIcons.newspaper,
                        title: "الجريدة الرسمية",
                        press: () => notNowPopup(),
                      ),
                      DrawerListTile(
                        icons: FontAwesomeIcons.listAlt,
                        title: "قوانين متنوعة",
                        press: () => notNowPopup(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              body: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  child: _widgetOptions.elementAt(c.selectedWidget.value)),
            ));
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
      middleText:
          "سيتم توفير هذه الخدمات لاحقا ما عدا خدمة الاستشارة القانونية",
      middleTextStyle: TextStyle(color: primaryColor),
    );
  }
}

class DrawerListTitle extends StatelessWidget {
  const DrawerListTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      title,
      style: TextStyle(
          color: secondaryColor, fontSize: 20, fontWeight: FontWeight.w600),
    ));
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icons,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icons;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: FaIcon(
        icons,
        color: secondaryColor,
        size: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: bgColor, fontSize: 18),
      ),
    );
  }
}
