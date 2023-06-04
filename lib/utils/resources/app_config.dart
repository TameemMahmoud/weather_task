import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppConfig {

  static List<LocalizationsDelegate> localizationsDelegates = const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    DefaultMaterialLocalizations.delegate,
    DefaultWidgetsLocalizations.delegate,
  ];
}
