import 'package:flutter/material.dart';
import 'package:bivouac/theme/color_palet.dart';

class ThemeConstants {
  static ThemeData lightTheme = ThemeData(
    
    brightness: Brightness.light,

    primaryColor: Colpal.primary,
    scaffoldBackgroundColor: Colpal.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colpal.white,
    ),

    colorScheme: ColorScheme.fromSeed(seedColor: Colpal.primary),
    useMaterial3: true,
  );
}