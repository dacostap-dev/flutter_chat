import 'dart:convert';

import 'package:chat_demo/core/constants.dart';
import 'package:chat_demo/presentation/chat/pages/chat.dart';
import 'package:chat_demo/presentation/message/pages/message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  final flutterLocalNotifications = FlutterLocalNotificationsPlugin();

  final http.Client _client = http.Client();

  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );

    await flutterLocalNotifications.initialize(
      const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (res) {
        print(res.payload.toString());
      },
    );
  }

  void firebaseNotification(BuildContext context) async {
    await init();

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('listen-onMessageOpenedApp');
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MessagesPage(
              contactId: message.data['senderId'],
            ),
          ),
          ModalRoute.withName(ChatPage.route));
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('listen-onMessage');
      await _showLocalNotification(message);
    });
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    final styleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title,
      htmlFormatTitle: true,
    );

    final androidDetails = AndroidNotificationDetails(
      'com.example.chat_demo.urgent',
      'mychannelid',
      importance: Importance.max,
      styleInformation: styleInformation,
      priority: Priority.max,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotifications.show(
      0,
      message.notification!.title,
      message.notification!.body,
      notificationDetails,
      payload: message.data['body'],
    );
  }

  Future<void> requestPermission() async {
    print('requestPermission');

    final messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('token $token');
    return token ?? '';
  }

  Future<void> sendNotification({
    required String body,
    required String receiverToken,
    required String senderId,
  }) async {
    print('sendNotification');
    print('receiverToken: $receiverToken');
    print('senderId: $senderId');

    try {
      final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');

      final res = await _client.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "key=${AppConstants.kFirebaseNotificationKey}",
        },
        body: jsonEncode({
          "to": receiverToken,
          "priority": 'high',
          "notification": {
            "title": "New Message",
            "body": body,
          },
          "data": {
            "status": "done",
            "senderId": senderId,
          },
        }),
      );
      print(res.statusCode);
      print(res.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
