import 'package:clock_demo/components/alarm_item.dart';
import 'package:clock_demo/controllers/alarms_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlarmTab extends StatelessWidget {
  const AlarmTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlarmController _alarmController = Provider.of<AlarmController>(context);
    return CustomScrollView(
        slivers: [
          SliverList(
              delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
                return AlarmItem(alarm: _alarmController.alarms[index]);
              }, childCount: _alarmController.alarms.length))
        ],
    );
  }
}
