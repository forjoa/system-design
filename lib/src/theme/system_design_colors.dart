import 'package:flutter/painting.dart';

/// Semantic color palette for the system design library.
///
/// All colors use semantic role names so the entire palette can be
/// switched (e.g. light ↔ dark) without touching individual components.
class SystemDesignColors {
  const SystemDesignColors({
    required this.background,
    required this.surface,
    required this.overlay,
    required this.foreground,
    required this.muted,
    required this.subtle,
    required this.primary,
    required this.primaryForeground,
    required this.border,
    required this.destructive,
    required this.destructiveForeground,
    required this.success,
    required this.successForeground,
  });

  // --- Surfaces ---
  final Color background;
  final Color surface;

  /// Semi-transparent tint used for hover/focus overlays.
  final Color overlay;

  // --- Content ---
  final Color foreground;
  final Color muted;
  final Color subtle;

  // --- Interactive ---
  final Color primary;
  final Color primaryForeground;
  final Color border;

  // --- Feedback ---
  final Color destructive;
  final Color destructiveForeground;
  final Color success;
  final Color successForeground;

  /// Default light palette — pure black & white with neutral grays.
  static const SystemDesignColors light = SystemDesignColors(
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF5F5F5),
    overlay: Color(0x0A000000),
    foreground: Color(0xFF0A0A0A),
    muted: Color(0xFF6B6B6B),
    subtle: Color(0xFFB0B0B0),
    primary: Color(0xFF0A0A0A),
    primaryForeground: Color(0xFFFFFFFF),
    border: Color(0xFFE0E0E0),
    destructive: Color(0xFF1A1A1A),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF2D2D2D),
    successForeground: Color(0xFFFFFFFF),
  );

  /// Default dark palette — inverted roles.
  static const SystemDesignColors dark = SystemDesignColors(
    background: Color(0xFF0A0A0A),
    surface: Color(0xFF1A1A1A),
    overlay: Color(0x0AFFFFFF),
    foreground: Color(0xFFF5F5F5),
    muted: Color(0xFF8C8C8C),
    subtle: Color(0xFF4A4A4A),
    primary: Color(0xFFF5F5F5),
    primaryForeground: Color(0xFF0A0A0A),
    border: Color(0xFF2C2C2C),
    destructive: Color(0xFFE0E0E0),
    destructiveForeground: Color(0xFF0A0A0A),
    success: Color(0xFFD0D0D0),
    successForeground: Color(0xFF0A0A0A),
  );

  SystemDesignColors copyWith({
    Color? background,
    Color? surface,
    Color? overlay,
    Color? foreground,
    Color? muted,
    Color? subtle,
    Color? primary,
    Color? primaryForeground,
    Color? border,
    Color? destructive,
    Color? destructiveForeground,
    Color? success,
    Color? successForeground,
  }) {
    return SystemDesignColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      overlay: overlay ?? this.overlay,
      foreground: foreground ?? this.foreground,
      muted: muted ?? this.muted,
      subtle: subtle ?? this.subtle,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      border: border ?? this.border,
      destructive: destructive ?? this.destructive,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      success: success ?? this.success,
      successForeground: successForeground ?? this.successForeground,
    );
  }

  SystemDesignColors lerp(SystemDesignColors other, double t) {
    return SystemDesignColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      subtle: Color.lerp(subtle, other.subtle, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryForeground:
          Color.lerp(primaryForeground, other.primaryForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveForeground: Color.lerp(
        destructiveForeground,
        other.destructiveForeground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      successForeground:
          Color.lerp(successForeground, other.successForeground, t)!,
    );
  }
}
