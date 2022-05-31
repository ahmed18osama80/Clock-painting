import 'package:alarm_flutter/data/enums.dart';
import 'package:flutter/foundation.dart';

class MenuInfo extends ChangeNotifier {
  late MenuType menuType;
  late String title;
  late String imageSource;

  MenuInfo(this.menuType, {required this.imageSource, required this.title});

  updateMenuInfo(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
