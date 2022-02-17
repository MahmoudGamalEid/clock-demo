import 'package:clock_demo/components/clock_item.dart';
import 'package:flutter/material.dart';

class WorldClockTab extends StatelessWidget {
  const WorldClockTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ClockItem(),
        ClockItem(),
        ClockItem(),
      ],
    );
  }
}
