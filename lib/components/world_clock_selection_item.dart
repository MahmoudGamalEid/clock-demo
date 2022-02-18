import 'package:clock_demo/controllers/world_clock_controller.dart';
import 'package:clock_demo/models/world_clock_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorldClockSelectionItem extends StatelessWidget {
  const WorldClockSelectionItem({Key? key, required this.clock}) : super(key: key);
  final WorldClock clock;
  @override
  Widget build(BuildContext context) {
    WorldClockController _worldClockController = Provider.of<WorldClockController>(context);
    return MaterialButton(
      height: 30,
      minWidth: double.infinity,
      onPressed: (){
        _worldClockController.addClock(clock);
        Navigator.of(context).pop();
      },
      child: Align(
        alignment: Alignment.topLeft,
          child: Text("${clock.cityName}, ${clock.regionName}")),
    );
  }
}
