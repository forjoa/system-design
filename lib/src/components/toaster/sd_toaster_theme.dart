import 'package:flutter/material.dart';

import '../../theme/system_design_theme.dart';

/// Per-component theme extension for [SdToast] and [SdToasterScope].
///
/// Access with `context.sdToasterTheme`.
class SdToasterTheme extends ThemeExtension<SdToasterTheme> {
  const SdToasterTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.maxVisible,
    required this.toastSpacing,
    required this.edgeInsets,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final double iconSize;

  /// Maximum number of toasts visible simultaneously.
  final int maxVisible;

  /// Vertical gap between stacked toasts.
  final double toastSpacing;

  /// Distance from screen edges.
  final EdgeInsets edgeInsets;

  factory SdToasterTheme.fromSdTheme(SystemDesignTheme t) {
    return SdToasterTheme(
      backgroundColor: t.colors.foreground,
      foregroundColor: t.colors.primaryForeground,
      borderColor: t.colors.border,
      borderRadius: BorderRadius.circular(t.radius.md),
      padding: EdgeInsets.symmetric(
        horizontal: t.spacing.md,
        vertical: t.spacing.sm,
      ),
      iconSize: 16,
      maxVisible: 3,
      toastSpacing: t.spacing.sm,
      edgeInsets: EdgeInsets.all(t.spacing.md),
    );
  }

  @override
  SdToasterTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? iconSize,
    int? maxVisible,
    double? toastSpacing,
    EdgeInsets? edgeInsets,
  }) {
    return SdToasterTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      iconSize: iconSize ?? this.iconSize,
      maxVisible: maxVisible ?? this.maxVisible,
      toastSpacing: toastSpacing ?? this.toastSpacing,
      edgeInsets: edgeInsets ?? this.edgeInsets,
    );
  }

  @override
  SdToasterTheme lerp(SdToasterTheme? other, double t) {
    if (other == null) return this;
    return SdToasterTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      iconSize: iconSize + (other.iconSize - iconSize) * t,
      maxVisible: t < 0.5 ? maxVisible : other.maxVisible,
      toastSpacing: toastSpacing + (other.toastSpacing - toastSpacing) * t,
      edgeInsets: EdgeInsets.lerp(edgeInsets, other.edgeInsets, t)!,
    );
  }
}
