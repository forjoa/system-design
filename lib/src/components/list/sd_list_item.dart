import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import 'sd_list_style.dart';

/// A single row within an [SdList].
///
/// ```dart
/// SdListItem(
///   title: Text('Settings'),
///   leading: Icon(Icons.settings),
///   onTap: () {},
/// )
/// ```
class SdListItem extends StatefulWidget {
  const SdListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.isDisabled = false,
    this.style,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool isDisabled;

  /// Per-instance style override.
  final SdListItemStyle? style;

  @override
  State<SdListItem> createState() => _SdListItemState();
}

class _SdListItemState extends State<SdListItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdListTheme;
    final sdTheme = context.sdTheme;

    final Color bg = widget.style?.selectedBackgroundColor != null && widget.isSelected
        ? widget.style!.selectedBackgroundColor!
        : widget.isSelected
            ? theme.itemSelectedBackgroundColor
            : widget.style?.backgroundColor ?? theme.itemBackgroundColor;

    final EdgeInsets padding = widget.style?.padding ?? theme.itemPadding;
    final double minHeight = widget.style?.minHeight ?? theme.itemMinHeight;

    final textColor = sdTheme.colors.foreground;
    final mutedColor = sdTheme.colors.muted;

    Widget content = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            if (widget.leading != null) ...[
              IconTheme(
                data: IconThemeData(color: textColor, size: 20),
                child: widget.leading!,
              ),
              SizedBox(width: sdTheme.spacing.md),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: (widget.style?.titleStyle ??
                            sdTheme.typography.bodyMedium)
                        .copyWith(color: textColor),
                    child: widget.title,
                  ),
                  if (widget.subtitle != null) ...[
                    SizedBox(height: sdTheme.spacing.xs / 2),
                    DefaultTextStyle(
                      style: (widget.style?.subtitleStyle ??
                              sdTheme.typography.bodySmall)
                          .copyWith(color: mutedColor),
                      child: widget.subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (widget.trailing != null) ...[
              SizedBox(width: sdTheme.spacing.md),
              IconTheme(
                data: IconThemeData(color: mutedColor, size: 20),
                child: widget.trailing!,
              ),
            ],
          ],
        ),
      ),
    );

    content = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      color: _hovered && !widget.isDisabled
          ? sdTheme.colors.overlay
          : bg,
      child: content,
    );

    if (widget.isDisabled) {
      return Opacity(
        opacity: theme.itemDisabledOpacity,
        child: content,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: content,
      ),
    );
  }
}
