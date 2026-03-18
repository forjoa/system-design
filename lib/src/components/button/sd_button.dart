import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import 'sd_button_style.dart';
import 'sd_button_theme.dart';

export 'sd_button_style.dart';
export 'sd_button_theme.dart';

/// A minimalist button component.
///
/// ```dart
/// SdButton(
///   label: 'Continue',
///   onPressed: () {},
/// )
///
/// SdButton(
///   label: 'Delete',
///   variant: SdButtonVariant.destructive,
///   onPressed: () {},
/// )
/// ```
class SdButton extends StatefulWidget {
  const SdButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = SdButtonVariant.filled,
    this.size = SdButtonSize.md,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.style,
  });

  final String label;
  final VoidCallback? onPressed;
  final SdButtonVariant variant;
  final SdButtonSize size;

  /// Optional leading icon widget.
  final Widget? icon;

  /// Optional trailing icon widget.
  final Widget? trailingIcon;

  final bool isLoading;
  final bool isDisabled;

  /// Per-instance style override. Non-null fields take precedence over [SdButtonTheme].
  final SdButtonStyle? style;

  @override
  State<SdButton> createState() => _SdButtonState();
}

class _SdButtonState extends State<SdButton> {
  bool _pressed = false;

  void _onTapDown(_) => setState(() => _pressed = true);
  void _onTapUp(_) => setState(() => _pressed = false);
  void _onTapCancel() => setState(() => _pressed = false);

  LinearGradient _buildGradient(SdButtonVariant variant, Color bg, double amount) {
    final bool hasSolidBackground =
        variant == SdButtonVariant.filled || variant == SdButtonVariant.destructive;
    final Color top = hasSolidBackground
        ? Color.lerp(bg, const Color(0xFFFFFFFF), amount)!
        : bg;
    return LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [bg, top],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.sdButtonTheme;
    final sdTheme = context.sdTheme;
    final bool disabled = widget.isDisabled || widget.isLoading;

    final SdButtonStyle variantStyle = switch (widget.variant) {
      SdButtonVariant.filled => theme.filledStyle,
      SdButtonVariant.outlined => theme.outlinedStyle,
      SdButtonVariant.ghost => theme.ghostStyle,
      SdButtonVariant.destructive => theme.destructiveStyle,
    };

    final EdgeInsets padding = widget.style?.padding ??
        switch (widget.size) {
          SdButtonSize.sm => theme.smPadding,
          SdButtonSize.md => theme.mdPadding,
          SdButtonSize.lg => theme.lgPadding,
        };

    final BorderRadius borderRadius = widget.style?.borderRadius ??
        switch (widget.size) {
          SdButtonSize.sm => theme.smBorderRadius,
          SdButtonSize.md => theme.mdBorderRadius,
          SdButtonSize.lg => theme.lgBorderRadius,
        };

    final Color bg =
        widget.style?.backgroundColor ?? variantStyle.backgroundColor!;
    final Color fg =
        widget.style?.foregroundColor ?? variantStyle.foregroundColor!;
    final Color border =
        widget.style?.borderColor ?? variantStyle.borderColor!;
    final TextStyle textStyle =
        (widget.style?.textStyle ?? variantStyle.textStyle ?? sdTheme.typography.labelLarge)
            .copyWith(color: fg);

    final double opacity = disabled
        ? 0.4
        : _pressed
            ? (widget.style?.pressedOpacity ?? theme.pressedOpacity)
            : 1.0;

    final double scale = _pressed && !disabled
        ? (widget.style?.pressedScale ?? theme.pressedScale)
        : 1.0;

    return GestureDetector(
      onTapDown: disabled ? null : _onTapDown,
      onTapUp: disabled ? null : _onTapUp,
      onTapCancel: disabled ? null : _onTapCancel,
      onTap: disabled ? null : widget.onPressed,
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: padding,
            decoration: BoxDecoration(
              gradient: _buildGradient(widget.variant, bg, theme.gradientHighlightAmount),
              borderRadius: borderRadius,
              border: Border.all(color: border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.isLoading)
                  Padding(
                    padding: EdgeInsets.only(right: sdTheme.spacing.xs),
                    child: SizedBox(
                      width: theme.loadingSize,
                      height: theme.loadingSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: fg,
                      ),
                    ),
                  )
                else if (widget.icon != null)
                  Padding(
                    padding: EdgeInsets.only(right: sdTheme.spacing.xs),
                    child: IconTheme(
                      data: IconThemeData(color: fg, size: theme.iconSize),
                      child: widget.icon!,
                    ),
                  ),
                Text(widget.label, style: textStyle),
                if (widget.trailingIcon != null)
                  Padding(
                    padding: EdgeInsets.only(left: sdTheme.spacing.xs),
                    child: IconTheme(
                      data: IconThemeData(color: fg, size: theme.iconSize),
                      child: widget.trailingIcon!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
