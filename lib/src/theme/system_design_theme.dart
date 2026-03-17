import 'package:flutter/material.dart';

import 'system_design_colors.dart';
import 'system_design_spacing.dart';
import 'system_design_radius.dart';
import 'system_design_typography.dart';

/// The root design token extension for the system design library.
///
/// Register this with [ThemeData.extensions] (via [SystemDesignThemeData]) and
/// access it anywhere in the widget tree with `context.sdTheme`.
///
/// ```dart
/// MaterialApp(
///   theme: SystemDesignThemeData.light(),
/// )
/// ```
class SystemDesignTheme extends ThemeExtension<SystemDesignTheme> {
  const SystemDesignTheme({
    required this.colors,
    required this.typography,
    required this.spacing,
    required this.radius,
    required this.fontFamily,
  });

  final SystemDesignColors colors;
  final SystemDesignTypography typography;
  final SystemDesignSpacing spacing;
  final SystemDesignRadius radius;

  /// The font family applied to all text styles. Defaults to `'Inter'`.
  final String fontFamily;

  // ---------------------------------------------------------------------------
  // Presets
  // ---------------------------------------------------------------------------

  /// Creates a light theme with all default token values.
  ///
  /// Any parameter can be overridden to customise the design system without
  /// forking the entire theme.
  factory SystemDesignTheme.light({
    String fontFamily = 'Inter',
    SystemDesignColors? colors,
    SystemDesignTypography? typography,
    SystemDesignSpacing? spacing,
    SystemDesignRadius? radius,
  }) {
    return SystemDesignTheme(
      fontFamily: fontFamily,
      colors: colors ?? SystemDesignColors.light,
      typography:
          typography ?? SystemDesignTypography.fromFontFamily(fontFamily),
      spacing: spacing ?? const SystemDesignSpacing(),
      radius: radius ?? const SystemDesignRadius(),
    );
  }

  /// Creates a dark theme with all default token values.
  factory SystemDesignTheme.dark({
    String fontFamily = 'Inter',
    SystemDesignColors? colors,
    SystemDesignTypography? typography,
    SystemDesignSpacing? spacing,
    SystemDesignRadius? radius,
  }) {
    return SystemDesignTheme(
      fontFamily: fontFamily,
      colors: colors ?? SystemDesignColors.dark,
      typography:
          typography ?? SystemDesignTypography.fromFontFamily(fontFamily),
      spacing: spacing ?? const SystemDesignSpacing(),
      radius: radius ?? const SystemDesignRadius(),
    );
  }

  // ---------------------------------------------------------------------------
  // ThemeExtension contract
  // ---------------------------------------------------------------------------

  @override
  SystemDesignTheme copyWith({
    SystemDesignColors? colors,
    SystemDesignTypography? typography,
    SystemDesignSpacing? spacing,
    SystemDesignRadius? radius,
    String? fontFamily,
  }) {
    return SystemDesignTheme(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      spacing: spacing ?? this.spacing,
      radius: radius ?? this.radius,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  SystemDesignTheme lerp(SystemDesignTheme? other, double t) {
    if (other == null) return this;
    return SystemDesignTheme(
      colors: colors.lerp(other.colors, t),
      typography: typography.lerp(other.typography, t),
      spacing: spacing.lerp(other.spacing, t),
      radius: radius.lerp(other.radius, t),
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
    );
  }
}
