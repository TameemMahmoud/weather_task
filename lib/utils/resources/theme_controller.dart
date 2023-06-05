import 'package:flutter/material.dart';

import 'app_colors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDarkTheme ? Colors.black : const Color(0xfff9f9f9),
      primarySwatch: Colors.purple,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      // textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      fontFamily: 'Tag',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontFamily: 'Tag',fontWeight: FontWeight.w600, color: !isDarkTheme ? AppColors.kGradientColor : const Color(0xfff9f9f9),),
        backgroundColor: isDarkTheme ? AppColors.kGradientColor : const Color(0xfff9f9f9),
        iconTheme:
            IconThemeData(color: isDarkTheme ? Colors.white : Colors.black),
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDarkTheme ? AppColors.kGradientColor : const Color(0xfff9f9f9),
      )
    );
  }
}
