import 'package:flutter/painting.dart';

/// Per-instance style override for [SdList].
class SdListStyle {
  const SdListStyle({
    this.padding,
    this.separatorColor,
    this.separatorThickness,
    this.backgroundColor,
    this.borderRadius,
  });

  final EdgeInsets? padding;
  final Color? separatorColor;
  final double? separatorThickness;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  SdListStyle copyWith({
    EdgeInsets? padding,
    Color? separatorColor,
    double? separatorThickness,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    return SdListStyle(
      padding: padding ?? this.padding,
      separatorColor: separatorColor ?? this.separatorColor,
      separatorThickness: separatorThickness ?? this.separatorThickness,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

/// Per-instance style override for [SdListItem].
class SdListItemStyle {
  const SdListItemStyle({
    this.padding,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.titleStyle,
    this.subtitleStyle,
    this.minHeight,
  });

  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? selectedBackgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double? minHeight;

  SdListItemStyle copyWith({
    EdgeInsets? padding,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    double? minHeight,
  }) {
    return SdListItemStyle(
      padding: padding ?? this.padding,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      titleStyle: titleStyle ?? this.titleStyle,
      subtitleStyle: subtitleStyle ?? this.subtitleStyle,
      minHeight: minHeight ?? this.minHeight,
    );
  }
}
