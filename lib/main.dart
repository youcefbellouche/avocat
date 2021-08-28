import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avocat/constant.dart';
import 'package:avocat/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      // home: LoginV2(),
      locale: Locale('ar', "DZ"),
      getPages: routes,
      debugShowCheckedModeBanner: false,
      title: 'Avocat',
      theme: ThemeData(
          // fontFamily: 'Almarai',
          // textTheme: TextTheme(bodyText1: TextStyle(fontFamily: 'Almarai')),
          primaryColor: primaryColor,
          secondaryHeaderColor: secondaryColor,
          fixTextFieldOutlineLabel: true),
    );
  }
}
