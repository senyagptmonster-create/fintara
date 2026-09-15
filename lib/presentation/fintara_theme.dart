import 'package:flutter/material.dart';

class FintaraTheme {
  static const bg = Color(0xFFF6FBF9);
  static const surface = Color(0xFFFFFFFF);
  static const edge = Color(0xFFD1FAE5);
  static const accent = Color(0xFF059669);
  static const accent2 = Color(0xFF34D399);
  static const ink = Color(0xFF064E3B);
  static const inkMuted = Color(0xFF047857);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.light(
        surface: surface,
        primary: accent,
        secondary: accent2,
        onSurface: ink,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: ink,
        elevation: 0,
      ),
    );
  }
}
