import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/services/local_storage.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    if (Platform.isAndroid) {
      final status = await Permission.notification.status;
      if (!status.isGranted) {
        await Permission.notification.request();
      }
    } else {
      await _messaging.requestPermission();
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _localNotifications.initialize(initSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      final isNotification = LocalStorage.getBool(kNotification);
      if (notification != null && !isNotification) {
        _showLocalNotification(notification);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = message.notification;
      final isNotification = LocalStorage.getBool(kNotification);
      if (notification != null && !isNotification) {
        _showLocalNotification(notification);
      }
    });
  }

  static Future<void> _showLocalNotification(
    RemoteNotification notification,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'fcm_channel',
      'Firebase Messaging',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
    );
  }
}
