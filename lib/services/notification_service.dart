import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lenden/functions/reminder_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notifService =
      NotificationService._internal();

  bool isInitialized = false;

  factory NotificationService() {
    return _notifService;
  }
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService._internal();

  _requestPermission() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  initialize() async {
    tz.initializeTimeZones();
    tz.Location? location = tz.getLocation('Asia/Dhaka');
    // final location = tz.getLocation('America/Toronto');
    tz.setLocalLocation(location);
    _requestPermission();
    if (isInitialized) {
      return;
    }
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('lenden');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
    isInitialized = true;
  }

  void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse,
  ) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('Payload: $payload');
    }
  }

  void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> scheduleNotification({
    required ReminderModel data,
  }) async {
    DateTime time = data.time;

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'booking_time_notification_channel_id',
      'booking_time_notification_channel_name',
      priority: Priority.high,
      importance: Importance.max,
      channelDescription: 'Reminder Notification',
      icon: 'lenden',
    );
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    if (time.isBefore(DateTime.now())) {
      await flutterLocalNotificationsPlugin.show(
        data.id,
        data.title,
        data.body,
        NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics,
        ),
      );
      return;
    }

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
        final tzTime = tz.TZDateTime(
      tz.local,
      time.year,
      time.month,
      time.day,
      time.hour,
      time.minute,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      data.id,
      data.title,
      data.body,
      tzTime,
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
