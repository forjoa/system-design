import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import 'sd_toaster_style.dart';

export 'sd_toaster_style.dart';

/// A single toast notification widget.
///
/// Rendered by [SdToasterScope] — not usually instantiated directly.
/// Use `SdToasterScope.of(context).show(SdToast(...))` to display a toast.
class SdToast extends StatelessWidget {
  const SdToast({
    super.key,
    required this.message,
    this.title,
    this.variant = SdToastVariant.defaultVariant,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.style,
  });

  final String message;
  final String? title;
  final SdToastVariant variant;
  final SdToastAction? action;
  final Duration duration;

  /// Per-instance style override.
  final SdToastStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdToasterTheme;
    final sdTheme = context.sdTheme;

    final Color bg = style?.backgroundColor ?? theme.backgroundColor;
    final Color fg = style?.foregroundColor ?? theme.foregroundColor;
    final BorderRadius radius = style?.borderRadius ?? theme.borderRadius;
    final EdgeInsets padding = style?.padding ?? theme.padding;

    // Variant icon — monochrome; shape distinguishes variant, not color.
    final IconData? variantIcon = switch (variant) {
      SdToastVariant.defaultVariant => null,
      SdToastVariant.success => Icons.check_circle_outline,
      SdToastVariant.warning => Icons.warning_amber_outlined,
      SdToastVariant.destructive => Icons.error_outline,
    };

    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
          border: Border.all(
            color: style?.borderColor ?? theme.borderColor,
          ),
        ),
        padding: padding,
        child: Row(
          children: [
            if (variantIcon != null) ...[
              Icon(variantIcon, color: fg, size: style?.iconSize ?? theme.iconSize),
              SizedBox(width: sdTheme.spacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: sdTheme.typography.labelLarge.copyWith(
                        color: fg,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  Text(
                    message,
                    style: sdTheme.typography.bodySmall.copyWith(
                      color: title != null ? sdTheme.colors.subtle : fg,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
            if (action != null) ...[
              SizedBox(width: sdTheme.spacing.sm),
              GestureDetector(
                onTap: action!.onPressed,
                child: Text(
                  action!.label,
                  style: sdTheme.typography.labelMedium.copyWith(
                    color: fg,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
