import 'package:clock_demo/components/add_alarm_modal_bottom_sheet.dart';
import 'package:clock_demo/components/add_world_clock_modal_bottom_sheet.dart';
import 'package:clock_demo/tabs/alarm_tab.dart';
import 'package:clock_demo/tabs/worldclock_tab.dart';
import 'package:clock_demo/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClockHomePage extends StatefulWidget {
  const ClockHomePage({Key? key}) : super(key: key);

  @override
  State<ClockHomePage> createState() => _ClockHomePageState();
}

class _ClockHomePageState extends State<ClockHomePage> {
  int _selectedIndex = 0;
  String _title = "World Clock";
  List<String> titles = [
    "World Clock",
    "Alarms",
  ];
  final List<Widget> _widgetOptions = <Widget>[
    const WorldClockTab(),
    const AlarmTab(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _title = titles[index];
    });
  }

  void showAlarmModalBottomSheet() {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (BuildContext context,) {
          return const AddAlarmModalBottomSheet();
        });
  }

  void showAddWorldClockModalBottomSheet() {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: (BuildContext context,) {
          return const AddWorldClockModalBottomSheet();
        });
  }

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
              switch (_selectedIndex) {
                case 0 :
                  showAddWorldClockModalBottomSheet();
                  break;
                case 1:
                  showAlarmModalBottomSheet();
                  break;
              }
            },
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                _title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined), label: "Clock"),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: "Alarms")
        ],
      ),
    );
  }
}
