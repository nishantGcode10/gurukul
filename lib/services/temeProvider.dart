import 'package:flutter/material.dart';

class AppTheme {
  //
  AppTheme._();

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Color(0xFFAEC3CE),
    cardTheme: CardTheme(
      color: Color(0xFFFFFFFF),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFAEC3CE),
    ),
    accentColor: Color(0xFFFF844B),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Color(0xFF1F1F1F),
    cardTheme: CardTheme(
      color: Color(0xFF282828),
    ),
    iconTheme: IconThemeData(
      color: Color(0xFFD562E6),
    ),
  );
}
