import 'package:clock_demo/components/clock_item.dart';
import 'package:clock_demo/components/world_clock_selection_item.dart';
import 'package:clock_demo/controllers/world_clock_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/world_clock_model.dart';

class WorldClockTab extends StatelessWidget {
  const WorldClockTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<WorldClock> _worldClocks = Provider.of<WorldClockController>(context).clocks;
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return ClockItem(clock: _worldClocks[index]);
                },childCount:_worldClocks.length ))
      ],
    );
  }
}
