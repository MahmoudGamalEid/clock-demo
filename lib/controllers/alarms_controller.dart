import 'package:clock_demo/services/notification_service.dart';
import 'package:flutter/cupertino.dart';

import '../models/alarm_model.dart';

class AlarmController extends ChangeNotifier{
  List<Alarm> _alarms = [];
  List<Alarm> get alarms => _alarms;
  addClock(Alarm alarm){
    _alarms.add(alarm);
    notifyListeners();
  }
  removeAlarm(Alarm alarm){
    for (var id in alarm.ids) {
      NotificationService.clearAlarm(id);
    }
    _alarms.remove(alarm);
    notifyListeners();
  }
}