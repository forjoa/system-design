import 'package:flutter/material.dart';

import '../../theme/system_design_theme.dart';

/// Per-component theme extension for [SdNavBar].
///
/// Register via [SystemDesignThemeData] or override in a [Theme] widget.
/// Access with `context.sdNavBarTheme`.
class SdNavBarTheme extends ThemeExtension<SdNavBarTheme> {
  const SdNavBarTheme({
    required this.backgroundColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.indicatorColor,
    required this.borderColor,
    required this.borderRadius,
    required this.margin,
    required this.padding,
    required this.itemPadding,
    required this.iconSize,
    required this.labelStyle,
    required this.showLabels,
  });

  final Color backgroundColor;

  /// Color applied to the active tab's icon and label.
  final Color activeColor;

  /// Color applied to inactive tabs' icon and label.
  final Color inactiveColor;

  /// Background fill of the animated pill behind the active tab.
  final Color indicatorColor;

  final Color borderColor;
  final BorderRadius borderRadius;

  /// Outer floating margin — creates the gap between the bar and screen edges.
  final EdgeInsets margin;

  /// Inner padding of the pill container.
  final EdgeInsets padding;

  /// Padding wrapping each individual tab item.
  final EdgeInsets itemPadding;

  /// Size of the tab icons in pixels.
  final double iconSize;

  /// Text style applied to tab labels.
  final TextStyle labelStyle;

  /// Whether to render text labels below icons.
  final bool showLabels;

  // ---------------------------------------------------------------------------
  // Factory: derive defaults from SystemDesignTheme tokens
  // ---------------------------------------------------------------------------

  factory SdNavBarTheme.fromSdTheme(SystemDesignTheme t) {
    return SdNavBarTheme(
      backgroundColor: t.colors.surface,
      activeColor: t.colors.foreground,
      inactiveColor: t.colors.muted,
      indicatorColor: t.colors.overlay,
      borderColor: t.colors.border,
      borderRadius: BorderRadius.circular(t.radius.full),
      margin: EdgeInsets.symmetric(
        horizontal: t.spacing.lg,
        vertical: t.spacing.md,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: t.spacing.xs,
        vertical: t.spacing.xs,
      ),
      itemPadding: EdgeInsets.symmetric(
        horizontal: t.spacing.md,
        vertical: t.spacing.sm,
      ),
      iconSize: 22,
      labelStyle: t.typography.labelSmall,
      showLabels: true,
    );
  }

  // ---------------------------------------------------------------------------
  // ThemeExtension contract
  // ---------------------------------------------------------------------------

  @override
  SdNavBarTheme copyWith({
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    Color? indicatorColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
    EdgeInsets? itemPadding,
    double? iconSize,
    TextStyle? labelStyle,
    bool? showLabels,
  }) {
    return SdNavBarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      itemPadding: itemPadding ?? this.itemPadding,
      iconSize: iconSize ?? this.iconSize,
      labelStyle: labelStyle ?? this.labelStyle,
      showLabels: showLabels ?? this.showLabels,
    );
  }

  @override
  SdNavBarTheme lerp(SdNavBarTheme? other, double t) {
    if (other == null) return this;
    return SdNavBarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
      margin: EdgeInsets.lerp(margin, other.margin, t)!,
      padding: EdgeInsets.lerp(padding, other.padding, t)!,
      itemPadding: EdgeInsets.lerp(itemPadding, other.itemPadding, t)!,
      iconSize: iconSize + (other.iconSize - iconSize) * t,
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      showLabels: t < 0.5 ? showLabels : other.showLabels,
    );
  }
}
