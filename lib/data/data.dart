import 'package:alarm_flutter/constants/theme_data.dart';

import 'alarm_info.dart';
import 'enums.dart';
import 'menuInfo.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      imageSource: 'assets/images/clock_icon.png', title: 'clock'),
  MenuInfo(MenuType.alarm,
      imageSource: 'assets/images/add_alarm.png', title: 'Alarm'),
  MenuInfo(MenuType.timer,
      imageSource: 'assets/images/timer_icon.png', title: 'Timer'),
  MenuInfo(MenuType.stopWatch,
      imageSource: 'assets/images/stopwatch_icon.png', title: 'Stopwatch'),
];

List<AlarmInfo> alarms = [
  AlarmInfo(title: 'Office ', gradientColors: GradientColors.sky,alarmDateTime: DateTime.now().add(const Duration(hours: 1,),), gradientColorIndex: 0,),
  AlarmInfo(title: 'Sport ', gradientColors: GradientColors.sunset,alarmDateTime: DateTime.now().add(const Duration(hours: 2,),), gradientColorIndex: 1,),
];
