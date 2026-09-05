import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThemePreset {
  neonBlue,
  neonPink,
  acidGreen,
  solarOrange,
}

class CyberColors {
  // Static constants with "Static" suffix to avoid naming conflicts with instance members
  static const Color backgroundStatic = Color(0xFF0A0E14);
  static const Color surfaceStatic = Color(0xFF151921);
  static const Color primaryStatic = Color(0xFF00F3FF); // Electric Blue
  static const Color secondaryStatic = Color(0xFFFF00E5); // Neon Pink
  static const Color accentStatic = Color(0xFF7000FF); // Purple
  static const Color textPrimaryStatic = Color(0xFFE0E6ED);
  static const Color textSecondaryStatic = Color(0xFF94A3B8);
  static const Color glassStatic = Color(0x1AFFFFFF);
  static const Color successStatic = Color(0xFF00FF94);
  static const Color errorStatic = Color(0xFFFF3131);

  final Color background;
  final Color surface;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color glass;
  final Color success;
  final Color error;

  const CyberColors({
    required this.background,
    required this.surface,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.glass,
    required this.success,
    required this.error,
  });

  factory CyberColors.fromPreset(ThemePreset preset) {
    switch (preset) {
      case ThemePreset.neonPink:
        return const CyberColors(
          background: backgroundStatic,
          surface: surfaceStatic,
          primary: Color(0xFFFF00E5), // Neon Pink
          secondary: Color(0xFF00F3FF), // Neon Blue
          accent: Color(0xFFBD00FF), // Deep Purple
          textPrimary: textPrimaryStatic,
          textSecondary: textSecondaryStatic,
          glass: glassStatic,
          success: successStatic,
          error: errorStatic,
        );
      case ThemePreset.acidGreen:
        return const CyberColors(
          background: backgroundStatic,
          surface: surfaceStatic,
          primary: Color(0xFF39FF14), // Acid Green
          secondary: Color(0xFF00F3FF),
          accent: Color(0xFF00FF94),
          textPrimary: textPrimaryStatic,
          textSecondary: textSecondaryStatic,
          glass: glassStatic,
          success: successStatic,
          error: errorStatic,
        );
      case ThemePreset.solarOrange:
        return const CyberColors(
          background: backgroundStatic,
          surface: surfaceStatic,
          primary: Color(0xFFFFAC1C), // Solar Orange
          secondary: Color(0xFFFF3131),
          accent: Color(0xFFFF00E5),
          textPrimary: textPrimaryStatic,
          textSecondary: textSecondaryStatic,
          glass: glassStatic,
          success: successStatic,
          error: errorStatic,
        );
      case ThemePreset.neonBlue:
      default:
        return const CyberColors(
          background: backgroundStatic,
          surface: surfaceStatic,
          primary: Color(0xFF00F3FF), // Electric Blue
          secondary: Color(0xFFFF00E5), // Neon Pink
          accent: Color(0xFF7000FF), // Purple
          textPrimary: textPrimaryStatic,
          textSecondary: textSecondaryStatic,
          glass: glassStatic,
          success: successStatic,
          error: errorStatic,
        );
    }
  }
}

class AppTheme {
  static ThemeData getTheme(ThemePreset preset) {
    final colors = CyberColors.fromPreset(preset);

    final baseTextTheme = GoogleFonts.jetBrainsMonoTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: colors.textPrimary,
      displayColor: colors.primary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: colors.surface,
        onSurface: colors.textPrimary,
      ),
      fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.jetBrainsMono(
          color: colors.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colors.glass, width: 1),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.surface,
        indicatorColor: colors.primary.withValues(alpha: 0.1),
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.jetBrainsMono(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colors.primary);
          }
          return IconThemeData(color: colors.textSecondary);
        }),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.background,
          textStyle: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: GoogleFonts.jetBrainsMono(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  static ThemeData get cyberTheme => getTheme(ThemePreset.neonBlue);
}
