import 'package:clock_demo/models/alarm_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/alarms_controller.dart';

class AlarmItem extends StatelessWidget {
  const AlarmItem({Key? key, required this.alarm}) : super(key: key);
  final Alarm alarm;
  @override
  Widget build(BuildContext context) {
    AlarmController _alarmController = Provider.of<AlarmController>(context);
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            onPressed: (context) {
              _alarmController.removeAlarm(alarm);
            },
            foregroundColor: Theme.of(context).colorScheme.primary,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('h:mm a').format(alarm.time),
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(alarm.label),
            ],
          ),
        ),
      ),
    );
  }
}
