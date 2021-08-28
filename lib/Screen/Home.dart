import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
              body: _widgetOptions.elementAt(c.selectedWidget.value),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  color: bgColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      offset: Offset(0, 10),
                      color: Color(0xff808080),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8),
                    child: GNav(
                      rippleColor: secondaryColor,
                      hoverColor: secondaryColor,
                      gap: 8,
                      activeColor: bgColor,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      duration: Duration(milliseconds: 400),
                      tabBackgroundColor: primaryColor,
                      color: primaryColor,
                      tabs: [
                        GButton(
                          icon: FontAwesomeIcons.listAlt,
                          iconColor: secondaryColor,
                          text: 'استشاراتي',
                        ),
                        GButton(
                          icon: FontAwesomeIcons.plusSquare,
                          iconColor: secondaryColor,
                          text: "استشارة",
                        ),
                        GButton(
                          icon: FontAwesomeIcons.cog,
                          iconColor: secondaryColor,
                          text: 'إعدادات',
                        ),
                      ],
                      selectedIndex: 1,
                      onTabChange: (index) {
                        c.change(index);
                      },
                    ),
                  ),
                ),
              ),
            ));
  }
}
