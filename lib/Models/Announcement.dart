import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  int? id;
  String? content;
  DateTime? date;
  String? uid;
  List<dynamic>? answer;
  List<dynamic>? avocat;
  String? status;
  String? statusText;

  Announcement(
      {this.answer,
      this.avocat,
      this.content,
      this.date,
      this.id,
      this.uid,
      this.status,
      this.statusText});

  Announcement.fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    content = json["content"];
    id = json["id"];
    answer = json["answer"];
    avocat = json["avocat"];
    status = json['status'];
    statusText = dictionnaire[json['status']];
    date = DateTime.fromMillisecondsSinceEpoch(json['id']);
  }
  Map<String, String> dictionnaire = {
    'novalid': 'لا يتم معالجتها حاليًا',
    'valid': 'يتم معالجتها',
    'finish': 'اكتمل العلاج',
    'cancel': 'إلغاء العلاج'
  };

  Future<void> add() async {
    try {
      await FirebaseFirestore.instance
          .collection("Announcement")
          .doc(id.toString())
          .set({
        'uid': this.uid,
        'content': this.content,
        'id': this.id,
        'status': this.status,
      });
      print('tasd');
    } catch (e) {
      print(e);
    }
  }
}
