import 'package:flutter/material.dart';

import '../../theme/system_design_theme.dart';

/// Per-component theme extension for [SdList] and [SdListItem].
///
/// Access with `context.sdListTheme`.
class SdListTheme extends ThemeExtension<SdListTheme> {
  const SdListTheme({
    required this.separatorColor,
    required this.separatorThickness,
    required this.itemPadding,
    required this.itemMinHeight,
    required this.itemBackgroundColor,
    required this.itemSelectedBackgroundColor,
    required this.itemDisabledOpacity,
  });

  final Color separatorColor;
  final double separatorThickness;
  final EdgeInsets itemPadding;
  final double itemMinHeight;
  final Color itemBackgroundColor;
  final Color itemSelectedBackgroundColor;
  final double itemDisabledOpacity;

  factory SdListTheme.fromSdTheme(SystemDesignTheme t) {
    return SdListTheme(
      separatorColor: t.colors.border,
      separatorThickness: 1,
      itemPadding: EdgeInsets.symmetric(
        horizontal: t.spacing.md,
        vertical: t.spacing.sm,
      ),
      itemMinHeight: 48,
      itemBackgroundColor: t.colors.background,
      itemSelectedBackgroundColor: t.colors.surface,
      itemDisabledOpacity: 0.4,
    );
  }

  @override
  SdListTheme copyWith({
    Color? separatorColor,
    double? separatorThickness,
    EdgeInsets? itemPadding,
    double? itemMinHeight,
    Color? itemBackgroundColor,
    Color? itemSelectedBackgroundColor,
    double? itemDisabledOpacity,
  }) {
    return SdListTheme(
      separatorColor: separatorColor ?? this.separatorColor,
      separatorThickness: separatorThickness ?? this.separatorThickness,
      itemPadding: itemPadding ?? this.itemPadding,
      itemMinHeight: itemMinHeight ?? this.itemMinHeight,
      itemBackgroundColor: itemBackgroundColor ?? this.itemBackgroundColor,
      itemSelectedBackgroundColor:
          itemSelectedBackgroundColor ?? this.itemSelectedBackgroundColor,
      itemDisabledOpacity: itemDisabledOpacity ?? this.itemDisabledOpacity,
    );
  }

  @override
  SdListTheme lerp(SdListTheme? other, double t) {
    if (other == null) return this;
    return SdListTheme(
      separatorColor: Color.lerp(separatorColor, other.separatorColor, t)!,
      separatorThickness:
          separatorThickness + (other.separatorThickness - separatorThickness) * t,
      itemPadding: EdgeInsets.lerp(itemPadding, other.itemPadding, t)!,
      itemMinHeight: itemMinHeight + (other.itemMinHeight - itemMinHeight) * t,
      itemBackgroundColor:
          Color.lerp(itemBackgroundColor, other.itemBackgroundColor, t)!,
      itemSelectedBackgroundColor: Color.lerp(
        itemSelectedBackgroundColor,
        other.itemSelectedBackgroundColor,
        t,
      )!,
      itemDisabledOpacity:
          itemDisabledOpacity + (other.itemDisabledOpacity - itemDisabledOpacity) * t,
    );
  }
}
