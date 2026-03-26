import 'package:flutter/material.dart';
import '../../theme/system_design_theme.dart';

class SdTextFieldTheme extends ThemeExtension<SdTextFieldTheme> {
  const SdTextFieldTheme({
    required this.borderRadius,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.errorBorderColor,
    required this.fillColor,
    required this.labelStyle,
    required this.inputStyle,
    required this.hintStyle,
    required this.errorStyle,
    required this.iconColor,
    required this.contentPadding,
  });

  final BorderRadius borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final TextStyle labelStyle;
  final TextStyle inputStyle;
  final TextStyle hintStyle;
  final TextStyle errorStyle;
  final Color iconColor;
  final EdgeInsets contentPadding;

  factory SdTextFieldTheme.fromSdTheme(SystemDesignTheme t) => SdTextFieldTheme(
        borderRadius: BorderRadius.circular(t.radius.md),
        borderColor: t.colors.border,
        focusedBorderColor: t.colors.foreground,
        errorBorderColor: const Color(0xFFE53E3E),
        fillColor: t.colors.surface,
        labelStyle: t.typography.labelMedium.copyWith(color: t.colors.muted),
        inputStyle: t.typography.bodyMedium.copyWith(color: t.colors.foreground),
        hintStyle: t.typography.bodyMedium.copyWith(color: t.colors.subtle),
        errorStyle: t.typography.labelSmall.copyWith(color: const Color(0xFFE53E3E)),
        iconColor: t.colors.muted,
        contentPadding: EdgeInsets.symmetric(
          horizontal: t.spacing.md,
          vertical: t.spacing.sm + 4,
        ),
      );

  @override
  SdTextFieldTheme copyWith({
    BorderRadius? borderRadius,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    Color? fillColor,
    TextStyle? labelStyle,
    TextStyle? inputStyle,
    TextStyle? hintStyle,
    TextStyle? errorStyle,
    Color? iconColor,
    EdgeInsets? contentPadding,
  }) =>
      SdTextFieldTheme(
        borderRadius: borderRadius ?? this.borderRadius,
        borderColor: borderColor ?? this.borderColor,
        focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
        errorBorderColor: errorBorderColor ?? this.errorBorderColor,
        fillColor: fillColor ?? this.fillColor,
        labelStyle: labelStyle ?? this.labelStyle,
        inputStyle: inputStyle ?? this.inputStyle,
        hintStyle: hintStyle ?? this.hintStyle,
        errorStyle: errorStyle ?? this.errorStyle,
        iconColor: iconColor ?? this.iconColor,
        contentPadding: contentPadding ?? this.contentPadding,
      );

  @override
  SdTextFieldTheme lerp(ThemeExtension<SdTextFieldTheme>? other, double t) {
    if (other is! SdTextFieldTheme) return this;
    return SdTextFieldTheme(
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      focusedBorderColor: Color.lerp(focusedBorderColor, other.focusedBorderColor, t)!,
      errorBorderColor: Color.lerp(errorBorderColor, other.errorBorderColor, t)!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      inputStyle: TextStyle.lerp(inputStyle, other.inputStyle, t)!,
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t)!,
      errorStyle: TextStyle.lerp(errorStyle, other.errorStyle, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      contentPadding: EdgeInsets.lerp(contentPadding, other.contentPadding, t)!,
    );
  }
}
