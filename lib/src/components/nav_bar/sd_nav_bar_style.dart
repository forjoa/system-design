import 'package:flutter/painting.dart';

/// Per-instance style override for [SdNavBar].
///
/// Any non-null field overrides the corresponding value from [SdNavBarTheme].
class SdNavBarStyle {
  const SdNavBarStyle({
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.indicatorColor,
    this.borderColor,
    this.borderRadius,
    this.margin,
    this.padding,
    this.itemPadding,
    this.iconSize,
    this.showLabels,
  });

  final Color? backgroundColor;

  /// Color of the active item's icon and label.
  final Color? activeColor;

  /// Color of inactive items' icon and label.
  final Color? inactiveColor;

  /// Background color of the pill indicator behind the active item.
  final Color? indicatorColor;

  final Color? borderColor;
  final BorderRadius? borderRadius;

  /// Outer margin — controls the floating gap from screen edges.
  final EdgeInsets? margin;

  /// Inner padding of the bar container.
  final EdgeInsets? padding;

  /// Padding around each individual tab item.
  final EdgeInsets? itemPadding;

  /// Icon size in pixels.
  final double? iconSize;

  /// Whether to show text labels below icons. Defaults to true.
  final bool? showLabels;

  SdNavBarStyle copyWith({
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
    bool? showLabels,
  }) {
    return SdNavBarStyle(
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
      showLabels: showLabels ?? this.showLabels,
    );
  }
}
