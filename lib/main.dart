import 'package:clock_demo/clock_homepage.dart';
import 'package:clock_demo/controllers/alarms_controller.dart';
import 'package:clock_demo/controllers/theme_controller.dart';
import 'package:clock_demo/controllers/world_clock_controller.dart';
import 'package:clock_demo/services/notification_service.dart';
import 'package:clock_demo/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          FutureProvider<String?>(
              create: (_) => FlutterNativeTimezone.getLocalTimezone(),
              initialData: null),
          ChangeNotifierProvider(create: (context) => ThemeController()),
          ChangeNotifierProvider(create: (context) => WorldClockController()),
          ChangeNotifierProvider(create: (context) => AlarmController()),
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
