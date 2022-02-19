import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static int lastId = 0;
  static Future _notificationDetails() async {
    const sound = 'daybreak.wav';
    return  NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id 1',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        sound: RawResourceAndroidNotificationSound(sound.split(".").first)
      ),
      iOS: const IOSNotificationDetails(sound: sound),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings);
  }
  static Future<int> showScheduledNotification({
    String? title = "Clock",
    String? body,
    required Time time,
  }) async {
    final scheduledDate = _scheduleDaily(time);
      _notifications.zonedSchedule(
        lastId + 1, // choose for each notification an index that is unique
        title,
        body,
          scheduledDate,
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime
      );
    lastId = lastId +1;
    return lastId;
    }

  static Future<List<int>> showRepeatedScheduledNotification({
    String? title = "Clock",
    String? body,
    required Time time,
    required List<int> days,
  }) async {
    int id = lastId;
    List<int> ids = [];
    final scheduledDates =
        _scheduleWeekly(time, days:days);
    for (int i = 0; i < scheduledDates.length; i++) {
      ids.add(i);
      final scheduledDate = scheduledDates[i];
      _notifications.zonedSchedule(
        id + i, // choose for each notification an index that is unique
        title,
        body,
        scheduledDate,
        await _notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
    lastId = ids.last;
    return ids;
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }

  static List<tz.TZDateTime> _scheduleWeekly(Time time,
      {required List<int> days}) {
    return days.map((day) {
      tz.TZDateTime scheduledDate = _scheduleDaily(time);

      while (day != scheduledDate.weekday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }
      return scheduledDate;
    }).toList();
  }

  static void clearAllAlarms(){
    _notifications.cancelAll();
    lastId = 0;
  }

  static void clearAlarm(int id){
    _notifications.cancel(id);
  }

}
