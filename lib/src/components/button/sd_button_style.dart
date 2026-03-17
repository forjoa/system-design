import 'package:flutter/painting.dart';

/// Visual variants for [SdButton].
enum SdButtonVariant {
  /// Solid fill — high emphasis action.
  filled,

  /// Border only, transparent fill — medium emphasis.
  outlined,

  /// No border or fill — low emphasis, inline actions.
  ghost,

  /// Destructive action — same monochrome palette, differentiated by label.
  destructive,
}

/// Size presets for [SdButton].
enum SdButtonSize {
  /// Compact — icon buttons, toolbars.
  sm,

  /// Default — most actions.
  md,

  /// Large — primary call-to-action.
  lg,
}

/// Per-instance style override for [SdButton].
///
/// Any non-null field overrides the corresponding value from [SdButtonTheme].
class SdButtonStyle {
  const SdButtonStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.pressedOpacity,
    this.pressedScale,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  /// Opacity of the button when pressed. Defaults to `0.7`.
  final double? pressedOpacity;

  /// Scale factor applied when pressed. Defaults to `0.97`.
  final double? pressedScale;

  SdButtonStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    TextStyle? textStyle,
    double? pressedOpacity,
    double? pressedScale,
  }) {
    return SdButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      pressedOpacity: pressedOpacity ?? this.pressedOpacity,
      pressedScale: pressedScale ?? this.pressedScale,
    );
  }
}
