import 'package:flutter/material.dart';
import 'package:weather_task/utils/app/my_app.dart';

class AppFonts {
  // change it with your colors like that
  static const TextStyle headlineStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static TextStyle cityFont = Theme.of(navigatorKey.currentState!.context)
      .textTheme
      .bodySmall!
      .copyWith(fontSize: 24, fontWeight: FontWeight.bold);

  static TextStyle smallFont =  Theme.of(navigatorKey.currentState!.context).textTheme.bodySmall!.copyWith(
    fontSize: 16,
  );
}
