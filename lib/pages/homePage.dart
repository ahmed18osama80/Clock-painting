import 'dart:async';

import 'package:alarm_flutter/pages/clockPage.dart';
import 'package:alarm_flutter/pages/clock_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../data/enums.dart';
import '../data/menuInfo.dart';
import 'alarmPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm:ss a').format(DateTime.now());
    var formattedDate = DateFormat('EEE, d MMM  yyyy').format(now);
    var timeZoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetString = '';
    if (!timeZoneString.startsWith('')) {
      offsetString = '+';
    }
    if (kDebugMode) {
      print(timeZoneString);
    }
    return Scrollbar(
      child: Scaffold(
        backgroundColor: const Color(0xFF2D2F41),
        body: Row(
          children: [
            Column(
              children: menuItems
                  .map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
                  .toList(),
            ),
            const VerticalDivider(
              color: Colors.white54,
              width: 6,
            ),
            Expanded(
              child: Consumer(
                builder: (BuildContext context,  MenuInfo value, Widget? child) {
                  if (value.menuType == MenuType.clock) {
                    return const ClockPage();
                  } else if (value.menuType == MenuType.alarm) {
                    return const AlarmPage();
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 26),
                    alignment: Alignment.center,
                    color: const Color(0xFF2D2F41),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            'Clock',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formattedTime,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 64,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                                size: MediaQuery.of(context).size.height / 2.5),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Time Zone',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.language,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'UTC $offsetString $timeZoneString',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          child: TextButton(
            style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                  ),
                ),
                backgroundColor: currentMenuInfo.menuType == value.menuType
                    ? Colors.deepOrangeAccent
                    : Colors.transparent,
                primary: currentMenuInfo.menuType == value.menuType
                    ? Colors.red
                    : Colors.transparent),
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenuInfo(currentMenuInfo);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1.5,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  currentMenuInfo.title,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
