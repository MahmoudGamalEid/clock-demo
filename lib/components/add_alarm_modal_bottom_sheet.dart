import 'package:clock_demo/controllers/alarms_controller.dart';
import 'package:clock_demo/controllers/theme_controller.dart';
import 'package:clock_demo/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../models/alarm_model.dart';

class AddAlarmModalBottomSheet extends StatefulWidget {
  const AddAlarmModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddAlarmModalBottomSheet> createState() =>
      _AddAlarmModalBottomSheetState();
}

class _AddAlarmModalBottomSheetState extends State<AddAlarmModalBottomSheet> {
  final Map<String, bool> _selectedDays = {
    "Monday": false,
    "Tuesday": false,
    "Wednesday": false,
    "Thursday": false,
    "Friday": false,
    "Saturday": false,
    "Sunday": false,
  };
  List<String> _days = [];
  Time _time = Time(DateTime.now().hour,DateTime.now().minute);
  String _label = "Alarm";
  @override
  void initState() {
    _days = _selectedDays.keys.toList();
    super.initState();
  }

  void createAlarm(AlarmController alarmController) async {
    List<int> indices = [];
    List<int> ids = [];
    for (int i = 0; i < _selectedDays.values.length; i++) {
      _selectedDays.values.elementAt(i) == true ? indices.add(i + 1) : null;
    }
    if (indices.isEmpty) {
      ids.add(await NotificationService.showScheduledNotification(
          time: _time, body: _label));
    } else {
      ids.addAll(await NotificationService.showRepeatedScheduledNotification(
          body: _label, time: _time, days: indices));
    }
    Alarm alarm = Alarm(
        ids: ids,
        time: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day,_time.hour, _time.minute, ),
        label: _label);
    alarmController.addClock(alarm);
  }

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Provider.of<ThemeController>(context);
    AlarmController _alarmController = Provider.of<AlarmController>(context);
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 15),
                ),
              ),
              const Text("Add Alarm"),
              MaterialButton(
                onPressed: () {
                  createAlarm(_alarmController);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 15),
                ),
              )
            ],
          ),
          SizedBox(
            height: 200,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                brightness: _themeController.isLightTheme
                    ? Brightness.light
                    : Brightness.dark,
              ),
              child: CupertinoDatePicker(
                onDateTimeChanged: (val) {
                  _time = Time(val.hour, val.minute);
                },
                mode: CupertinoDatePickerMode.time,
                use24hFormat: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Alarm label',
                  ),
                  onChanged: (val) {
                    setState(() {
                      _label = val;
                    });
                  },
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Align(alignment: Alignment.topLeft, child: Text("Repeat")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: ToggleButtons(
                children: _days
                    .map((e) => Text(
                          e.substring(0, 3),
                          style: Theme.of(context).textTheme.bodyText2,
                        ))
                    .toList(),
                isSelected: _selectedDays.values.toList(),
                onPressed: (index) {
                  setState(() {
                    _selectedDays[_days[index]] = !_selectedDays[_days[index]]!;
                  });
                },
                renderBorder: true,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
