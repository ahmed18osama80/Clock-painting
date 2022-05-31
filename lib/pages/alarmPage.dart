import 'package:alarm_flutter/data/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants/theme_data.dart';
import '../data/alarm_helper.dart';
import '../data/alarm_info.dart';
import '../data/data.dart';
import '../main.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late DateTime _alarmTime;
  late String _alarmTimeString;
  final AlarmHelper _alarmHelper = AlarmHelper();
  late Future<List<AlarmInfo>> _alarms;
  late List<AlarmInfo> _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      if (kDebugMode) {
        print('------database initialized');
      }
      // loadAlarms();
    });
    super.initState();
  }

  // void loadAlarms() {
  //   _alarms = _alarmHelper.getAlarms();
  //   if (mounted) setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Alarm ',
              style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 24,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: alarms.map<Widget>((alarm) {
                var gradientColor = GradientTemplate
                    .gradientTemplate[alarm.gradientColorIndex].colors;
                var title = alarms[alarms.length - 1].title;
                return Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: gradientColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        24,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: gradientColor.last.withOpacity(.4),
                        blurRadius: 8,
                        spreadRadius: 4,
                        offset: const Offset(
                          4,
                          4,
                        ),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Text(
                                title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontFamily: 'avenir'),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Switch(
                                  value: true,
                                  onChanged: (bool value) {},
                                  activeColor: Colors.indigoAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        'Mon- Fri',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'avenir',
                            fontSize: 27),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '07:00 AM',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontFamily: 'avenir',
                              fontSize: 27,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 37,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).followedBy([
                DottedBorder(
                  strokeWidth: 4,
                  color: CustomColors.clockOutline,
                  dashPattern: const [5, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(34),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: CustomColors.clockBG,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        DateTime scheduleAlarmDateTime;
                        if (_alarmTime.isAfter(DateTime.now())) {
                          scheduleAlarmDateTime = _alarmTime;
                        } else {
                          scheduleAlarmDateTime =
                              _alarmTime.add(const Duration(days: 1));
                          var alarmInfo = AlarmInfo(
                            alarmDateTime: scheduleAlarmDateTime,
                            title: 'title',
                            gradientColorIndex: 1,
                            // alarmDateTime: DateTime.now().add(const Duration(seconds: 10)),
                          );
                          _alarmHelper.insertAlarm(alarmInfo);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/add_alarm.png',
                              scale: 1.5),
                          const SizedBox(
                            height: 12,
                          ),
                          const Text(
                            'Add Alarm',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm(scheduledNotificationDateTime) async {
    var scheduledNotificationDateTime =
        DateTime.now().add(const Duration(seconds: 10));
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var alarmInfo = AlarmInfo(
      title: 'title',
      gradientColorIndex: 1,
      alarmDateTime: DateTime.now().add(const Duration(seconds: 10)),
    );
    await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime;
    } else {
      scheduleAlarmDateTime = _alarmTime.add(const Duration(days: 1));
    }

    var alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime);
    Navigator.pop(context);
    // loadAlarms();
  }

  void deleteAlarm(int id) {
    // _alarmHelper.delete(id);
    //unsubscribe for notification
    // loadAlarms();
  }
}
