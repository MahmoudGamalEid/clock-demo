import 'package:clock_demo/components/clock_item.dart';
import 'package:clock_demo/components/local_time_clock.dart';
import 'package:clock_demo/controllers/world_clock_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorldClockTab extends StatelessWidget {
  const WorldClockTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WorldClockController _worldClockController =
        Provider.of<WorldClockController>(context);
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: LocalTimeClock(),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          return ClockItem(clock: _worldClockController.clocks[index]);
        }, childCount: _worldClockController.clocks.length))
      ],
    );
  }
}
