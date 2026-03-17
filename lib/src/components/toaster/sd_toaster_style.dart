import 'package:flutter/painting.dart';

/// Visual variants for [SdToast].
enum SdToastVariant {
  /// Default informational toast.
  defaultVariant,

  /// Positive outcome.
  success,

  /// Non-critical warning.
  warning,

  /// Destructive or error state.
  destructive,
}

/// Inline action displayed inside a [SdToast].
class SdToastAction {
  const SdToastAction({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final void Function() onPressed;
}

/// Per-instance style override for [SdToast].
class SdToastStyle {
  const SdToastStyle({
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.iconSize,
  });

  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final double? iconSize;

  SdToastStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    BorderRadius? borderRadius,
    EdgeInsets? padding,
    double? iconSize,
  }) {
    return SdToastStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      iconSize: iconSize ?? this.iconSize,
    );
  }
}
