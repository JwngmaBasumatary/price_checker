import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme:  const AppBarTheme(
      elevation: 1,
      backgroundColor: Colors.deepPurple,
      iconTheme: IconThemeData(
        color: Colors.black12
      ),

    )

);
ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff15161a),
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: Color(0xff15161a),
    )

);
