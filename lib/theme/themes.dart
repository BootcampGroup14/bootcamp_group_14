import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
   colorScheme: ColorScheme.dark(
        primary: Color(0xFF3DA0A7),
        secondary: Color(0xFF1A2030),
   ),
  backgroundColor: Color(0xFF657B9A1A),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xFFF7F7F9)),
    backgroundColor: Color(0xFF020818),
    titleTextStyle: TextStyle(
      color: Color(0xFFF7F7F9),
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF3DA0A7),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Color(0xFFFFFFFF)),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Color(0xFF1A2030),
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(color: Color(0xFF0A2533)), //
    ),
    iconTheme: MaterialStateProperty.all(
      IconThemeData(color: Color(0xFFFFFFFF)),
    ),
  ),

);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Color(0xFF70B9BE),
    secondary: Color(0xFF042628),
    //background: Color(0xFF3DA0A7),
    onPrimary: Color(0xFFFFFFFF),
    onBackground: Color(0xFF0A2533),
  ),
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xFF0A2533)),
    backgroundColor: Color(0xFFFFFFFF),
    titleTextStyle: TextStyle(
      color: Color(0xFF0A2533),
    ),
  ),
    backgroundColor: Color(0xFF3DA0A7),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF042628),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Color(0xFF0A2533)),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.white,
    labelTextStyle: MaterialStateProperty.all(
      TextStyle(color: Color(0xFF0A2533)), //
    ),
    iconTheme: MaterialStateProperty.all(
      IconThemeData(color: Color(0xFFFFFFFF)),
    ),
  ),
);
