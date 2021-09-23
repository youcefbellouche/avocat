import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:avocat/Models/Announcement.dart';
import 'package:avocat/Screen/AnnouncemetInfo.dart';
import 'package:avocat/constant.dart';

import 'Button.dart';

// ignore: must_be_immutable
class AnnouncementsCard extends StatelessWidget {
  AnnouncementsCard({Key? key, required this.announcement, required this.me})
      : super(key: key);
  final Announcement announcement;
  bool me;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 12, right: 12),
      padding: EdgeInsets.all(12),
      height: 145,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 0.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText(
              announcement.content!.length > 50
                  ? announcement.content!.substring(0, 50) + "..."
                  : announcement.content!,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'الحالة :  ${announcement.statusText}',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Abutton(
                    size: Size(155, 30),
                    colors: Colors.white,
                    onpressed: () {
                      Get.to(() => AnnouncemetInfo(
                            me: me,
                            announcement: announcement,
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'شاهد التفاصيل',
                          style: TextStyle(color: secondaryColor),
                        ),
                        Icon(
                          LineIcons.arrowCircleLeft,
                          color: secondaryColor,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
