import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class SummerTheme extends ThemeExtension<SummerTheme> {
  const SummerTheme({
    this.primaryColor = const Color(0xFF4D85BD),
  });

  final Color primaryColor;

  ThemeData _base(final ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: GoogleFonts.ubuntuTextTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        elevation: 5,
        backgroundColor: colorScheme.inversePrimary,
        scrolledUnderElevation: 5.0,
        shadowColor: colorScheme.shadow,
      ),
    );
  }

  ThemeData toThemeData() {
    return _base(ColorScheme.fromSeed(seedColor: primaryColor));
  }

  @override
  ThemeExtension<SummerTheme> copyWith({
    Color? primaryColor,
  }) =>
      SummerTheme(primaryColor: primaryColor ?? this.primaryColor);

  @override
  ThemeExtension<SummerTheme> lerp(
      covariant ThemeExtension<SummerTheme>? other, double t,) {
    if (other is! SummerTheme) {
      return this;
    }

    return SummerTheme(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
    );
  }
}