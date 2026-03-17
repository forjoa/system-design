import 'package:flutter/painting.dart';

/// Per-instance style override for [SdDialog].
class SdDialogStyle {
  const SdDialogStyle({
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.maxWidth,
    this.titleStyle,
    this.descriptionStyle,
    this.barrierColor,
    this.elevation,
  });

  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? maxWidth;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final Color? barrierColor;
  final double? elevation;

  SdDialogStyle copyWith({
    Color? backgroundColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? maxWidth,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
    Color? barrierColor,
    double? elevation,
  }) {
    return SdDialogStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      maxWidth: maxWidth ?? this.maxWidth,
      titleStyle: titleStyle ?? this.titleStyle,
      descriptionStyle: descriptionStyle ?? this.descriptionStyle,
      barrierColor: barrierColor ?? this.barrierColor,
      elevation: elevation ?? this.elevation,
    );
  }
}
