import 'package:flutter/painting.dart';

/// Typography scale for the system design library.
///
/// All [TextStyle] instances are constructed with [fontFamily] sourced from
/// [SystemDesignTheme.fontFamily] (default `'Inter'`), so swapping the font
/// family is a single-field change in the theme.
class SystemDesignTypography {
  const SystemDesignTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.headingLarge,
    required this.headingMedium,
    required this.headingSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.code,
  });

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle headingSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  /// Monospace style for code snippets.
  final TextStyle code;

  /// Builds the default typography scale for [fontFamily].
  factory SystemDesignTypography.fromFontFamily(String fontFamily) {
    return SystemDesignTypography(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 48,
        fontWeight: FontWeight.w700,
        height: 1.1,
        letterSpacing: -1.5,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w700,
        height: 1.15,
        letterSpacing: -1.0,
      ),
      headingLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.2,
        letterSpacing: -0.5,
      ),
      headingMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.25,
      ),
      headingSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.57,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.1,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      ),
      code: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
    );
  }

  SystemDesignTypography copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? headingLarge,
    TextStyle? headingMedium,
    TextStyle? headingSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? code,
  }) {
    return SystemDesignTypography(
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      headingLarge: headingLarge ?? this.headingLarge,
      headingMedium: headingMedium ?? this.headingMedium,
      headingSmall: headingSmall ?? this.headingSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      code: code ?? this.code,
    );
  }

  SystemDesignTypography lerp(SystemDesignTypography other, double t) {
    return SystemDesignTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      headingLarge: TextStyle.lerp(headingLarge, other.headingLarge, t)!,
      headingMedium: TextStyle.lerp(headingMedium, other.headingMedium, t)!,
      headingSmall: TextStyle.lerp(headingSmall, other.headingSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
      code: TextStyle.lerp(code, other.code, t)!,
    );
  }
}
