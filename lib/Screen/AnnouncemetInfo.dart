import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:avocat/Models/Announcement.dart';
import 'package:avocat/constant.dart';

// ignore: must_be_immutable
class AnnouncemetInfo extends StatelessWidget {
  AnnouncemetInfo({required this.announcement, Key? key}) : super(key: key);

  Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: bgColor),
        title: Text(
          'التفاصيل استشارة',
          style: TextStyle(fontWeight: FontWeight.bold, color: bgColor),
        ),
      ),
      body: Accordion(
        contentBackgroundColor: secondaryColor.withOpacity(0.05),
        contentBorderRadius: 8,
        contentBorderColor: primaryColor,
        contentBorderWidth: 1,
        maxOpenSections: 3,
        children: [
          AccordionSection(
            isOpen: true,
            header: Text('استشارة',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('رقم استشارة : ${announcement.id}'),
                Text(
                  'استشارة :  ${announcement.content!}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  'تاريخ :  ${announcement.date!.year}/${announcement.date!.month}/${announcement.date!.day}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                Text(
                  'الحالة :  ${announcement.statusText}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          AccordionSection(
            isOpen: false,
            header: Text('الجواب 1',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            content: announcement.answer != null &&
                    announcement.answer![0].isNotEmpty
                ? Text(announcement.answer![0])
                : Text('لا جواب في الوقت الراهن'),
          ),
          AccordionSection(
              isOpen: false,
              header: Text('محامي 1',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              content: announcement.avocat != null &&
                      announcement.avocat![0].isNotEmpty
                  ? Text(announcement.avocat![0])
                  : Text('لا محام في الوقت الراهن')),
          AccordionSection(
            isOpen: false,
            header: Text('الجواب 2',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            content: announcement.answer != null &&
                    announcement.answer![1].isNotEmpty
                ? Text(announcement.answer![1])
                : Text('لا جواب في الوقت الراهن'),
          ),
          AccordionSection(
              isOpen: false,
              header: Text('محامي 2',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              content: announcement.avocat != null &&
                      announcement.avocat![0].isNotEmpty
                  ? Text(announcement.avocat![0])
                  : Text('لا محام في الوقت الراهن')),
          AccordionSection(
            isOpen: false,
            header: Text('الجواب 3',
                style: TextStyle(color: Colors.white, fontSize: 17)),
            content: announcement.answer != null &&
                    announcement.answer![2].isNotEmpty
                ? Text(announcement.answer![2])
                : Text('لا جواب في الوقت الراهن'),
          ),
          AccordionSection(
              isOpen: false,
              header: Text('محامي 3',
                  style: TextStyle(color: Colors.white, fontSize: 17)),
              content: announcement.avocat != null &&
                      announcement.avocat![0].isNotEmpty
                  ? Text(announcement.avocat![0])
                  : Text('لا محام في الوقت الراهن')),
        ],
      ),
    );
  }
}
