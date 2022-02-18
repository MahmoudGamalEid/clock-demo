import 'package:clock_demo/clock_homepage.dart';
import 'package:clock_demo/controllers/theme_controller.dart';
import 'package:clock_demo/controllers/world_clock_controller.dart';
import 'package:clock_demo/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeController()),
          ChangeNotifierProvider(create: (context) => WorldClockController()),
        ],
        child: Consumer<ThemeController>(
          builder: (context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Analog Clock',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            home: const ClockHomePage(),
          ),
        ));
  }
}
