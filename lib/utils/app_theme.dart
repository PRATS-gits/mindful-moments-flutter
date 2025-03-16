import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Calm color palette
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color secondaryBlue = Color(0xFF5FB0E5);
  static const Color lightBlue = Color(0xFFD4E8FA);
  static const Color mintGreen = Color(0xFF98D7C2);
  static const Color paleGreen = Color(0xFFE3F2ED);
  static const Color lavender = Color(0xFFD4C2FC);
  static const Color paleLavender = Color(0xFFEAE4F9);
  static const Color blushPink = Color(0xFFF8E1E7);
  static const Color background = Color(0xFFF9FCFF);
  static const Color textDark = Color(0xFF2E3A59);
  static const Color textLight = Color(0xFF8F9BB3);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: secondaryBlue,
        background: background,
        surface: Colors.white,
        onSurface: textDark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        TextTheme(
          displayLarge: const TextStyle(color: textDark),
          displayMedium: const TextStyle(color: textDark),
          displaySmall: const TextStyle(color: textDark),
          headlineMedium: const TextStyle(color: textDark),
          headlineSmall: const TextStyle(
            color: textDark,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: const TextStyle(
            color: textDark,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: const TextStyle(
            color: textDark,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: const TextStyle(color: textLight),
          bodyLarge: const TextStyle(color: textDark),
          bodyMedium: const TextStyle(color: textDark),
          bodySmall: const TextStyle(color: textLight),
          labelLarge: const TextStyle(
            color: textDark,
            fontWeight: FontWeight.w500,
          ),
          labelMedium: const TextStyle(color: textLight),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: background,
        centerTitle: true,
        foregroundColor: textDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: primaryBlue.withOpacity(0.1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primaryBlue),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryBlue,
        unselectedItemColor: textLight,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
