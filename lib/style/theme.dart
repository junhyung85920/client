import 'package:flutter/material.dart';
import 'package:pop_up_the_local/app.dart';

class ColorTheme {
  static var defaultColor = const Color.fromARGB(255, 0, 0, 0);
  static var background = const Color(0xff1BE89E);
  static var stroke = const Color(0xff212325);
  static var pointColor = const Color(0xff484376);
  static var pointText = const Color(0xffFFFFFF);
  static var selected = const Color.fromARGB(255, 124, 255, 142);
  static var unselected = const Color(0xff757575);
}

ThemeData theme = ThemeData(
  // Cursor Style
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: ColorTheme.defaultColor,
  ),

  canvasColor: Colors.transparent,

  // Appbar Style
  appBarTheme: AppBarTheme(
    backgroundColor: ColorTheme.background,
    toolbarHeight: 56,
    titleTextStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    foregroundColor: Colors.white,
    centerTitle: true,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    enableFeedback: false,
    selectedItemColor: ColorTheme.selected,
    unselectedItemColor: ColorTheme.unselected,
  ),

  // Scaffold Style
  scaffoldBackgroundColor: Colors.white,

  // Icon Style (select icon size in [16, 20, 24])
  iconTheme: IconThemeData(color: ColorTheme.defaultColor),

  // Text Style
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: App.font,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    bodyLarge: TextStyle(
      fontSize: 24,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      color: ColorTheme.defaultColor,
      fontFamily: App.font,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      color: ColorTheme.defaultColor,
      fontWeight: FontWeight.bold,
      fontFamily: App.font,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      color: ColorTheme.defaultColor,
      fontWeight: FontWeight.bold,
      fontFamily: App.font,
    ),
  ),
);
