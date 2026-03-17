import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';
import 'sd_list_style.dart';

export 'sd_list_item.dart';
export 'sd_list_style.dart';
export 'sd_list_theme.dart';

/// A themed, scrollable list widget.
///
/// Thin wrapper over [ListView.builder] that automatically applies consistent
/// separators, padding, and empty-state handling from [SdListTheme].
///
/// ```dart
/// SdList<String>(
///   items: ['Apple', 'Banana', 'Cherry'],
///   itemBuilder: (context, item, index) => SdListItem(
///     title: Text(item),
///   ),
/// )
/// ```
class SdList<T> extends StatelessWidget {
  const SdList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separator,
    this.header,
    this.footer,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.scrollController,
    this.emptyState,
    this.style,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Custom separator. Defaults to a 1px horizontal divider from theme.
  final Widget? separator;

  final Widget? header;
  final Widget? footer;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final ScrollController? scrollController;

  /// Widget shown when [items] is empty.
  final Widget? emptyState;

  /// Per-instance style override.
  final SdListStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdListTheme;

    if (items.isEmpty && emptyState != null) {
      return emptyState!;
    }

    final divider = separator ??
        Divider(
          height: style?.separatorThickness ?? theme.separatorThickness,
          thickness: style?.separatorThickness ?? theme.separatorThickness,
          color: style?.separatorColor ?? theme.separatorColor,
          indent: 0,
          endIndent: 0,
        );

    final int headerCount = header != null ? 1 : 0;
    final int footerCount = footer != null ? 1 : 0;
    final int totalCount = headerCount + items.length + footerCount;

    return Container(
      decoration: style?.backgroundColor != null || style?.borderRadius != null
          ? BoxDecoration(
              color: style?.backgroundColor,
              borderRadius: style?.borderRadius,
            )
          : null,
      child: ListView.separated(
        controller: scrollController,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: style?.padding ?? padding ?? EdgeInsets.zero,
        itemCount: totalCount,
        separatorBuilder: (_, index) {
          // No divider between header and first item, or last item and footer.
          if (header != null && index == 0) return const SizedBox.shrink();
          if (footer != null && index == totalCount - 2) {
            return const SizedBox.shrink();
          }
          return divider;
        },
        itemBuilder: (context, index) {
          if (header != null && index == 0) return header!;
          if (footer != null && index == totalCount - 1) return footer!;
          final itemIndex = index - headerCount;
          return itemBuilder(context, items[itemIndex], itemIndex);
        },
      ),
    );
  }
}

/// A horizontal rule divider styled by [SdListTheme].
class SdDivider extends StatelessWidget {
  const SdDivider({super.key, this.indent, this.endIndent});

  final double? indent;
  final double? endIndent;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdListTheme;
    return Divider(
      height: theme.separatorThickness,
      thickness: theme.separatorThickness,
      color: theme.separatorColor,
      indent: indent ?? 0,
      endIndent: endIndent ?? 0,
    );
  }
}
