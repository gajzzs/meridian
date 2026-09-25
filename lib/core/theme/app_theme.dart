import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors
  static const Color primary = Color(0xFF000000);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF0E1C2F);
  static const Color onPrimaryContainer = Color(0xFF77849C);

  // Secondary Colors
  static const Color secondary = Color(0xFF426086);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFB3D1FD);
  static const Color onSecondaryContainer = Color(0xFF3B5A7F);
  static const Color secondaryFixed = Color(0xFFD3E4FF);

  // Tertiary Colors
  static const Color tertiary = Color(0xFF000000);
  static const Color tertiaryContainer = Color(0xFF2A1700);
  static const Color onTertiaryContainer = Color(0xFFB87500);
  static const Color tertiaryFixed = Color(0xFFFFDDB8);
  static const Color tertiaryFixedDim = Color(0xFFFFB95F);
  static const Color onTertiaryFixed = Color(0xFF2A1700);

  // Surface Colors
  static const Color surface = Color(0xFFF8F9FF);
  static const Color onSurface = Color(0xFF0B1C30);
  static const Color surfaceVariant = Color(0xFFD3E4FE);
  static const Color onSurfaceVariant = Color(0xFF44474C);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEFF4FF);
  static const Color surfaceContainer = Color(0xFFE5EEFF);
  static const Color surfaceContainerHigh = Color(0xFFDCE9FF);
  static const Color surfaceContainerHighest = Color(0xFFD3E4FE);

  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Outline
  static const Color outline = Color(0xFF75777D);
  static const Color outlineVariant = Color(0xFFC5C6CD);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onPrimary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        surfaceContainerHighest: surfaceContainerHighest,
        outline: outline,
        outlineVariant: outlineVariant,
      ),
      scaffoldBackgroundColor: surface,
      textTheme: _buildTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: surface.withOpacity(0.85),
        elevation: 0,
        scrolledUnderElevation: 1,
        iconTheme: const IconThemeData(color: onSurface),
        titleTextStyle: _buildTextTheme().titleLarge,
      ),
      cardTheme: CardTheme(
        color: surfaceContainerLowest,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.02,
          ),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return TextTheme(
      // Display
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 40,
        height: 1.2,
        letterSpacing: -0.02,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 30,
        height: 1.2,
        letterSpacing: -0.015,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),

      // Headline
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 32,
        height: 1.25,
        letterSpacing: -0.02,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        height: 1.27,
        letterSpacing: -0.01,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        height: 1.33,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),

      // Title
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        height: 1.33,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.01,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.02,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),

      // Body
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        height: 1.5,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        height: 1.43,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        height: 1.33,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),

      // Label
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.01,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.02,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 10,
        height: 1.4,
        letterSpacing: 0.06,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
    );
  }

  // Metric Display (for large numbers)
  static TextStyle metricDisplay = GoogleFonts.spaceGrotesk(
    fontSize: 28,
    height: 1.14,
    letterSpacing: -0.03,
    fontWeight: FontWeight.w700,
    color: onSurface,
  );
}
