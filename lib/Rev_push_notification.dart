import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: camel_case_types
class Rev_PushNotification {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  static Future<void> _requestPermission() async {
    if (Platform.isAndroid) return;

    await _messaging.requestPermission();
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static Stream<RemoteMessage> get onMessage => FirebaseMessaging.onMessage;
  static Stream<RemoteMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp;

  static Future<void> initialize(
    SelectNotificationCallback onSelectNotification,
  ) async {
    await _messaging.getInitialMessage();
    await _requestPermission();

    await _initializeLocalNotification(onSelectNotification);
    await _configureAndroidChannel();

    await _openInitialScreenFromMessage(onSelectNotification);
  }

  static void invokeLocalNotification(RemoteMessage remoteMessage) async {
    RemoteNotification? notification = remoteMessage.notification;
    AndroidNotification? android = remoteMessage.notification?.android;

    if (notification != null && android != null) {
      await _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'Rev', // id
            'Wasfaty', // title
            'This channel is used for important notifications.',
            icon: android.smallIcon,
          ),
        ),
        payload: jsonEncode(remoteMessage.data),
      );
    }
  }

  static Future<void> _configureAndroidChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'BreakingCodeChannel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await _localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> _openInitialScreenFromMessage(
    SelectNotificationCallback onSelectNotification,
  ) async {
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage?.data != null) {
      onSelectNotification(jsonEncode(initialMessage!.data));
    }
  }

  static Future<void> _initializeLocalNotification(
    SelectNotificationCallback onSelectNotification,
  ) async {
    final android = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    final ios = IOSInitializationSettings();

    final initsetting = InitializationSettings(android: android, iOS: ios);

    await _localNotification.initialize(
      initsetting,
      onSelectNotification: onSelectNotification,
    );
  }

  subscrib(String topic) async {
    await _messaging.subscribeToTopic(topic);
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      topic: true,
    });
  }

  unSubscrib(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      topic: false,
    });
  }
}
