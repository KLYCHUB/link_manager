import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 27, 27, 27),
      elevation: 0,
    ),
    primaryColor: const Color.fromARGB(255, 27, 27, 27),
  );
}

class AppColors {
  static const Color buttonBackgroundColor = Color.fromARGB(255, 27, 27, 27);
  static const Color linkButtonTextColor = Color.fromARGB(255, 27, 27, 27);
  static const Color backgroundColor = Color.fromARGB(255, 27, 27, 27);
  static const Color bottomNavBarBackgroundColor = Colors.white;
  static const Color linkManagerBackgroundColor = Colors.white;
  static const Color appBarColor = Colors.white;
}
