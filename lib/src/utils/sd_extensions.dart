import 'package:flutter/material.dart';

import '../theme/system_design_theme.dart';
import '../components/button/sd_button_theme.dart';
import '../components/list/sd_list_theme.dart';
import '../components/dialog/sd_dialog_theme.dart';
import '../components/toaster/sd_toaster_theme.dart';
import '../components/nav_bar/sd_nav_bar_theme.dart';

/// [BuildContext] extension accessors for system design tokens.
///
/// Usage:
/// ```dart
/// final theme = context.sdTheme;
/// final colors = context.sdTheme.colors;
/// ```
extension SdThemeContext on BuildContext {
  /// The root [SystemDesignTheme] token extension.
  SystemDesignTheme get sdTheme =>
      Theme.of(this).extension<SystemDesignTheme>()!;

  /// Per-component theme for [SdButton].
  SdButtonTheme get sdButtonTheme =>
      Theme.of(this).extension<SdButtonTheme>() ??
      SdButtonTheme.fromSdTheme(sdTheme);

  /// Per-component theme for [SdList] and [SdListItem].
  SdListTheme get sdListTheme =>
      Theme.of(this).extension<SdListTheme>() ??
      SdListTheme.fromSdTheme(sdTheme);

  /// Per-component theme for [SdDialog].
  SdDialogTheme get sdDialogTheme =>
      Theme.of(this).extension<SdDialogTheme>() ??
      SdDialogTheme.fromSdTheme(sdTheme);

  /// Per-component theme for [SdToast] and [SdToasterScope].
  SdToasterTheme get sdToasterTheme =>
      Theme.of(this).extension<SdToasterTheme>() ??
      SdToasterTheme.fromSdTheme(sdTheme);

  /// Per-component theme for [SdNavBar].
  SdNavBarTheme get sdNavBarTheme =>
      Theme.of(this).extension<SdNavBarTheme>() ??
      SdNavBarTheme.fromSdTheme(sdTheme);
}
