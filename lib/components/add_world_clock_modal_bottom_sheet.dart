import 'package:flutter/material.dart';
import 'package:timezone/standalone.dart' as tz;

class AddWorldClockModalBottomSheet extends StatelessWidget {
  const AddWorldClockModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
          heightFactor: 0.9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  if (index < tz.timeZoneDatabase.locations.keys.length) {
                    return Text(
                        tz.timeZoneDatabase.locations.keys.elementAt(index));
                  }
                }, childCount: tz.timeZoneDatabase.locations.keys.length)),
              ],
            ),
          )),
    );
  }
}
