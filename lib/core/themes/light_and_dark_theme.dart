import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  textTheme: Typography.material2021().black,
  brightness: Brightness.light,
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.light(
    surface: Color(0xffF1F1F1),),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.red,
    foregroundColor: AppColors.textDark,
  ),
);

final ThemeData darkTheme = ThemeData(
  textTheme: Typography.material2021().white,
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  scaffoldBackgroundColor: Color(0xff212121),
  colorScheme: ColorScheme.dark(
    surface: Color(0xff606368),),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.red,
    foregroundColor: AppColors.textLight,
  ),
);