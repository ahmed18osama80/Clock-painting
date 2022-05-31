import 'package:alarm_flutter/data/enums.dart';
import 'package:alarm_flutter/data/menuInfo.dart';
import 'package:alarm_flutter/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('Clock');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {});

  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid,iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider<MenuInfo>(
          create: (BuildContext context) => MenuInfo(
                MenuType.clock,
                title: '',
                imageSource: '',
              ),
          child: const HomePage()),
    );
  }
}
