import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:avocat/Models/Announcement.dart';
import 'package:avocat/Widget/announcementsCard.dart';

import '../constant.dart';

class Myannouncements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Announcement')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .orderBy('id', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length > 0) {
                return ListView.builder(
                    padding: EdgeInsets.only(bottom: 24, top: 12),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Announcement announcement = Announcement.fromJson(
                          snapshot.data!.docs[index].data()
                              as Map<String, dynamic>);
                      return AnnouncementsCard(announcement: announcement);
                    });
              } else {
                return Center(
                    child: Text(
                  'لا يوجد استشارة',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ));
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
          }),
    );
  }
}