import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import 'sd_dialog_style.dart';
import 'sd_dialog_theme.dart';

export 'sd_dialog_style.dart';
export 'sd_dialog_theme.dart';

/// A minimalist modal dialog.
///
/// The widget itself is a plain [StatelessWidget] — render it standalone or
/// via [showSdDialog] to display it as a route.
///
/// ```dart
/// showSdDialog(
///   context: context,
///   builder: (_) => SdDialog(
///     title: Text('Confirm'),
///     description: 'Are you sure you want to delete this item?',
///     actions: [
///       SdButton(label: 'Cancel', variant: SdButtonVariant.ghost, onPressed: () => Navigator.pop(context)),
///       SdButton(label: 'Delete', variant: SdButtonVariant.destructive, onPressed: () {}),
///     ],
///   ),
/// )
/// ```
class SdDialog extends StatelessWidget {
  const SdDialog({
    super.key,
    this.title,
    this.description,
    this.body,
    this.actions,
    this.showCloseButton = true,
    this.style,
  });

  final Widget? title;

  /// Convenience plain-text body. Ignored if [body] is provided.
  final String? description;

  /// Free-form content rendered below the title.
  final Widget? body;

  /// Row of action widgets (typically [SdButton]s) rendered at the bottom.
  final List<Widget>? actions;

  final bool showCloseButton;

  /// Per-instance style override.
  final SdDialogStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdDialogTheme;
    final sdTheme = context.sdTheme;

    final Color bg = style?.backgroundColor ?? theme.backgroundColor;
    final BorderRadius radius = style?.borderRadius ?? theme.borderRadius;
    final EdgeInsets padding = style?.padding ?? theme.padding;
    final EdgeInsets margin = style?.margin ?? theme.margin;
    final double maxWidth = style?.maxWidth ?? theme.maxWidth;

    return Center(
      child: Padding(
        padding: margin,
        child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: bg,
              borderRadius: radius,
              border: Border.all(
                color: theme.borderColor,
                width: theme.borderWidth,
              ),
            ),
            padding: padding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null || showCloseButton)
                  Padding(
                    padding: EdgeInsets.only(bottom: sdTheme.spacing.sm),
                    child: Row(
                      children: [
                        if (title != null)
                          Expanded(
                            child: DefaultTextStyle(
                              style: (style?.titleStyle ??
                                      sdTheme.typography.headingSmall)
                                  .copyWith(color: sdTheme.colors.foreground),
                              child: title!,
                            ),
                          ),
                        if (showCloseButton)
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.close,
                              size: 18,
                              color: sdTheme.colors.muted,
                            ),
                          ),
                      ],
                    ),
                  ),
                if (body != null)
                  body!
                else if (description != null)
                  Text(
                    description!,
                    style: (style?.descriptionStyle ??
                            sdTheme.typography.bodyMedium)
                        .copyWith(color: sdTheme.colors.muted),
                  ),
                if (actions != null && actions!.isNotEmpty) ...[
                  SizedBox(height: sdTheme.spacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (int i = 0; i < actions!.length; i++) ...[
                        if (i > 0) SizedBox(width: sdTheme.spacing.sm),
                        actions![i],
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

/// Displays an [SdDialog] as a modal route.
///
/// Uses [showGeneralDialog] to allow full control over barrier color and
/// transition — avoids relying on Material's opinionated dialog styling.
Future<T?> showSdDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
}) {
  final dialogTheme = Theme.of(context).extension<SdDialogTheme>();
  final barrierColor =
      dialogTheme?.barrierColor ?? const Color(0x80000000);

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss',
    barrierColor: barrierColor,
    transitionDuration: const Duration(milliseconds: 200),
    routeSettings: routeSettings,
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: child,
        ),
      );
    },
  );
}
