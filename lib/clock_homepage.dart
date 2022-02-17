import 'package:clock_demo/components/analog_clock.dart';
import 'package:clock_demo/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClockHomePage extends StatelessWidget {
  const ClockHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController _themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: MaterialButton(
          shape: const CircleBorder(),
          onPressed: () {
            _themeController.changeTheme();
          },
          child: Icon(
            _themeController.isLightTheme
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_sharp,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          MaterialButton(
            shape: const CircleBorder(),
            onPressed: () {
              print("add a new world clock!");
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize:
            const Size(double.infinity, kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left:16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "World Clock",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('h:mm a').format(DateTime.now()),
                  style: Theme.of(context).textTheme.headline1,
                ),
                AnalogClock(
                  time: DateTime.now(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined), label: "Clock"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarms")
        ],
      ),
    );
  }
}
