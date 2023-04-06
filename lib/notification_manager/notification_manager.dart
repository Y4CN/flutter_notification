import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationAndroidSettings =
        const AndroidInitializationSettings('flutter_logo');

    DarwinInitializationSettings initializationiosSetting =
        DarwinInitializationSettings(
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationAndroidSettings,
      iOS: initializationiosSetting,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  Future<void> simpleNotif() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('channelId', 'channelName',
            priority: Priority.high,
            importance: Importance.max,
            icon: 'flutter_logo',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Show TITLE',
      "body",
      notificationDetails,
    );
  }

  Future<void> bigPictureNotif() async {
    BigPictureStyleInformation bigPictureStyleInformation =
        const BigPictureStyleInformation(
            DrawableResourceAndroidBitmap('flutter_logo'),
            contentTitle: 'Y4CN',
            largeIcon: DrawableResourceAndroidBitmap('flutter_logo'));

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'BigId',
      'BigName',
      priority: Priority.high,
      importance: Importance.max,
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      1,
      'Show TITLE',
      "body",
      notificationDetails,
    );
  }

  Future<void> multiNotif() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      importance: Importance.max,
      groupKey: 'commonMessage',
    );

    //WE CAN DO THIS with INDEX :D 

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    flutterLocalNotificationsPlugin.show(
      0,
      'New Notif',
      "User 1",
      notificationDetails,
    );

    Future.delayed(const Duration(seconds: 1), () {
      flutterLocalNotificationsPlugin.show(
        1,
        'New Notif',
        "User 2",
        notificationDetails,
      );
    });
  }
}
