import 'package:flutter/material.dart';

import '../../theme/system_design_theme.dart';
import 'sd_button_style.dart';

/// Per-component theme extension for [SdButton].
///
/// Register via [SystemDesignThemeData] or override in a [Theme] widget.
/// Access with `context.sdButtonTheme`.
class SdButtonTheme extends ThemeExtension<SdButtonTheme> {
  const SdButtonTheme({
    required this.filledStyle,
    required this.outlinedStyle,
    required this.ghostStyle,
    required this.destructiveStyle,
    required this.smPadding,
    required this.mdPadding,
    required this.lgPadding,
    required this.smBorderRadius,
    required this.mdBorderRadius,
    required this.lgBorderRadius,
    required this.pressedOpacity,
    required this.pressedScale,
    required this.iconSize,
    required this.loadingSize,
    this.gradientHighlightAmount = 0.26,
  });

  /// Base styles for each variant (colors only — size-specific values set separately).
  final SdButtonStyle filledStyle;
  final SdButtonStyle outlinedStyle;
  final SdButtonStyle ghostStyle;
  final SdButtonStyle destructiveStyle;

  /// Padding per size.
  final EdgeInsets smPadding;
  final EdgeInsets mdPadding;
  final EdgeInsets lgPadding;

  /// Border radius per size.
  final BorderRadius smBorderRadius;
  final BorderRadius mdBorderRadius;
  final BorderRadius lgBorderRadius;

  final double pressedOpacity;
  final double pressedScale;

  /// Icon size in pixels.
  final double iconSize;

  /// Loading indicator size in pixels.
  final double loadingSize;

  /// How much white is blended into the top of the button gradient.
  /// 0.0 = no gradient, 1.0 = fully white. Default is 0.10 (subtle).
  final double gradientHighlightAmount;

  // ---------------------------------------------------------------------------
  // Factory: derive defaults from SystemDesignTheme tokens
  // ---------------------------------------------------------------------------

  factory SdButtonTheme.fromSdTheme(SystemDesignTheme t) {
    final c = t.colors;
    final r = t.radius;
    final sp = t.spacing;
    return SdButtonTheme(
      filledStyle: SdButtonStyle(
        backgroundColor: c.primary,
        foregroundColor: c.primaryForeground,
        borderColor: c.primary,
        textStyle: t.typography.labelLarge,
      ),
      outlinedStyle: SdButtonStyle(
        backgroundColor: c.background,
        foregroundColor: c.foreground,
        borderColor: c.border,
        textStyle: t.typography.labelLarge,
      ),
      ghostStyle: SdButtonStyle(
        backgroundColor: const Color(0x00000000),
        foregroundColor: c.foreground,
        borderColor: const Color(0x00000000),
        textStyle: t.typography.labelLarge,
      ),
      destructiveStyle: SdButtonStyle(
        backgroundColor: c.destructive,
        foregroundColor: c.destructiveForeground,
        borderColor: c.destructive,
        textStyle: t.typography.labelLarge,
      ),
      smPadding: EdgeInsets.symmetric(horizontal: sp.sm, vertical: sp.xs),
      mdPadding: EdgeInsets.symmetric(horizontal: sp.md, vertical: sp.sm),
      lgPadding: EdgeInsets.symmetric(horizontal: sp.lg, vertical: sp.md),
      smBorderRadius: BorderRadius.circular(r.sm),
      mdBorderRadius: BorderRadius.circular(r.md),
      lgBorderRadius: BorderRadius.circular(r.md),
      pressedOpacity: 0.7,
      pressedScale: 0.97,
      iconSize: 16,
      loadingSize: 14,
    );
  }

  // ---------------------------------------------------------------------------
  // ThemeExtension contract
  // ---------------------------------------------------------------------------

  @override
  SdButtonTheme copyWith({
    SdButtonStyle? filledStyle,
    SdButtonStyle? outlinedStyle,
    SdButtonStyle? ghostStyle,
    SdButtonStyle? destructiveStyle,
    EdgeInsets? smPadding,
    EdgeInsets? mdPadding,
    EdgeInsets? lgPadding,
    BorderRadius? smBorderRadius,
    BorderRadius? mdBorderRadius,
    BorderRadius? lgBorderRadius,
    double? pressedOpacity,
    double? pressedScale,
    double? iconSize,
    double? loadingSize,
    double? gradientHighlightAmount,
  }) {
    return SdButtonTheme(
      filledStyle: filledStyle ?? this.filledStyle,
      outlinedStyle: outlinedStyle ?? this.outlinedStyle,
      ghostStyle: ghostStyle ?? this.ghostStyle,
      destructiveStyle: destructiveStyle ?? this.destructiveStyle,
      smPadding: smPadding ?? this.smPadding,
      mdPadding: mdPadding ?? this.mdPadding,
      lgPadding: lgPadding ?? this.lgPadding,
      smBorderRadius: smBorderRadius ?? this.smBorderRadius,
      mdBorderRadius: mdBorderRadius ?? this.mdBorderRadius,
      lgBorderRadius: lgBorderRadius ?? this.lgBorderRadius,
      pressedOpacity: pressedOpacity ?? this.pressedOpacity,
      pressedScale: pressedScale ?? this.pressedScale,
      iconSize: iconSize ?? this.iconSize,
      loadingSize: loadingSize ?? this.loadingSize,
      gradientHighlightAmount: gradientHighlightAmount ?? this.gradientHighlightAmount,
    );
  }

  @override
  SdButtonTheme lerp(SdButtonTheme? other, double t) {
    if (other == null) return this;
    return SdButtonTheme(
      filledStyle: filledStyle,
      outlinedStyle: outlinedStyle,
      ghostStyle: ghostStyle,
      destructiveStyle: destructiveStyle,
      smPadding: EdgeInsets.lerp(smPadding, other.smPadding, t)!,
      mdPadding: EdgeInsets.lerp(mdPadding, other.mdPadding, t)!,
      lgPadding: EdgeInsets.lerp(lgPadding, other.lgPadding, t)!,
      smBorderRadius: BorderRadius.lerp(smBorderRadius, other.smBorderRadius, t)!,
      mdBorderRadius: BorderRadius.lerp(mdBorderRadius, other.mdBorderRadius, t)!,
      lgBorderRadius: BorderRadius.lerp(lgBorderRadius, other.lgBorderRadius, t)!,
      pressedOpacity: pressedOpacity + (other.pressedOpacity - pressedOpacity) * t,
      pressedScale: pressedScale + (other.pressedScale - pressedScale) * t,
      iconSize: iconSize + (other.iconSize - iconSize) * t,
      loadingSize: loadingSize + (other.loadingSize - loadingSize) * t,
      gradientHighlightAmount:
          gradientHighlightAmount + (other.gradientHighlightAmount - gradientHighlightAmount) * t,
    );
  }
}
