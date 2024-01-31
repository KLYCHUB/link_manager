import 'package:flutter/material.dart';

import '../color/colors.dart';

class AppButtonStyle {
  static const ButtonStyle buttonStyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(
      AppColors.buttonBackgroundColor,
    ),
  );
}

class AppElevatedButtonStyle {
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonBackgroundColor,
  );
}