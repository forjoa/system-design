import 'package:flutter/material.dart';

import '../../theme/system_design_theme.dart';

/// Per-component theme extension for [SdDialog].
///
/// Access with `context.sdDialogTheme`.
class SdDialogTheme extends ThemeExtension<SdDialogTheme> {
  const SdDialogTheme({
    required this.backgroundColor,
    required this.borderRadius,
    required this.padding,
    required this.margin,
    required this.maxWidth,
    required this.barrierColor,
    required this.borderColor,
    required this.borderWidth,
  });

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  /// Horizontal (and vertical) margin between the dialog and the screen edges.
  final EdgeInsets margin;
  final double maxWidth;
  final Color barrierColor;
  final Color borderColor;
  final double borderWidth;

  factory SdDialogTheme.fromSdTheme(SystemDesignTheme t) {
    return SdDialogTheme(
      backgroundColor: t.colors.background,
      borderRadius: BorderRadius.circular(t.radius.lg),
      padding: EdgeInsets.all(t.spacing.lg),
      margin: EdgeInsets.symmetric(horizontal: t.spacing.lg),
      maxWidth: 480,
      barrierColor: const Color(0x80000000),
      borderColor: t.colors.border,
      borderWidth: 1,
    );
  }

  @override
  SdDialogTheme copyWith({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? maxWidth,
    Color? barrierColor,
    Color? borderColor,
    double? borderWidth,
  }) {
    return SdDialogTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      maxWidth: maxWidth ?? this.maxWidth,
      barrierColor: barrierColor ?? this.barrierColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  @override
  SdDialogTheme lerp(SdDialogTheme? other, double t) {
    if (other == null) return this;
    return SdDialogTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      margin: EdgeInsets.lerp(margin, other.margin, t)!,
      maxWidth: maxWidth + (other.maxWidth - maxWidth) * t,
      barrierColor: Color.lerp(barrierColor, other.barrierColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: borderWidth + (other.borderWidth - borderWidth) * t,
    );
  }
}
