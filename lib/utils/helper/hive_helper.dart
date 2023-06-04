import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveHelper {
  static const tempMood = 'tempMood';
  static const mood = 'mood';

  //

  static void setMood(bool isDark) {
    Hive.box(HiveHelper.mood).put(HiveHelper.mood, isDark);
  }

  static bool getMood() {
    return Hive.box(HiveHelper.mood).isNotEmpty
        ? Hive.box(HiveHelper.mood).get(HiveHelper.mood)
        : false;
  }

  static void setTempMood(bool isCelsius) {
    Hive.box(HiveHelper.tempMood).put(HiveHelper.tempMood, isCelsius);
  }

  static bool getTempMood() {
    return Hive.box(HiveHelper.tempMood).isNotEmpty
        ? Hive.box(HiveHelper.tempMood).get(HiveHelper.tempMood)
        : false;
  }


}
