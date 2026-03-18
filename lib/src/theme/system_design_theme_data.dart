import 'package:flutter/material.dart';

import 'system_design_colors.dart';
import 'system_design_radius.dart';
import 'system_design_spacing.dart';
import 'system_design_theme.dart';
import 'system_design_typography.dart';
import '../components/button/sd_button_theme.dart';
import '../components/list/sd_list_theme.dart';
import '../components/dialog/sd_dialog_theme.dart';
import '../components/toaster/sd_toaster_theme.dart';
import '../components/nav_bar/sd_nav_bar_theme.dart';

/// Factory that produces a fully configured [ThemeData] for the system design
/// library.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: SystemDesignThemeData.light(),
///   darkTheme: SystemDesignThemeData.dark(),
/// )
/// ```
abstract final class SystemDesignThemeData {
  SystemDesignThemeData._();

  /// Builds a light [ThemeData] with all system design extensions registered.
  ///
  /// Every parameter is optional — defaults produce the canonical
  /// black & white minimalist light theme.
  static ThemeData light({
    String fontFamily = 'Inter',
    SystemDesignColors? colors,
    SystemDesignTypography? typography,
    SystemDesignSpacing? spacing,
    SystemDesignRadius? radius,
    SdButtonTheme? buttonTheme,
    SdListTheme? listTheme,
    SdDialogTheme? dialogTheme,
    SdToasterTheme? toasterTheme,
    SdNavBarTheme? navBarTheme,
  }) {
    final sdTheme = SystemDesignTheme.light(
      fontFamily: fontFamily,
      colors: colors,
      typography: typography,
      spacing: spacing,
      radius: radius,
    );
    return _buildThemeData(
      sdTheme: sdTheme,
      brightness: Brightness.light,
      buttonTheme: buttonTheme,
      listTheme: listTheme,
      dialogTheme: dialogTheme,
      toasterTheme: toasterTheme,
      navBarTheme: navBarTheme,
    );
  }

  /// Builds a dark [ThemeData] with all system design extensions registered.
  static ThemeData dark({
    String fontFamily = 'Inter',
    SystemDesignColors? colors,
    SystemDesignTypography? typography,
    SystemDesignSpacing? spacing,
    SystemDesignRadius? radius,
    SdButtonTheme? buttonTheme,
    SdListTheme? listTheme,
    SdDialogTheme? dialogTheme,
    SdToasterTheme? toasterTheme,
    SdNavBarTheme? navBarTheme,
  }) {
    final sdTheme = SystemDesignTheme.dark(
      fontFamily: fontFamily,
      colors: colors,
      typography: typography,
      spacing: spacing,
      radius: radius,
    );
    return _buildThemeData(
      sdTheme: sdTheme,
      brightness: Brightness.dark,
      buttonTheme: buttonTheme,
      listTheme: listTheme,
      dialogTheme: dialogTheme,
      toasterTheme: toasterTheme,
      navBarTheme: navBarTheme,
    );
  }

  static ThemeData _buildThemeData({
    required SystemDesignTheme sdTheme,
    required Brightness brightness,
    SdButtonTheme? buttonTheme,
    SdListTheme? listTheme,
    SdDialogTheme? dialogTheme,
    SdToasterTheme? toasterTheme,
    SdNavBarTheme? navBarTheme,
  }) {
    final c = sdTheme.colors;
    return ThemeData(
      brightness: brightness,
      fontFamily: sdTheme.fontFamily,
      scaffoldBackgroundColor: c.background,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.primaryForeground,
        secondary: c.muted,
        onSecondary: c.foreground,
        error: c.destructive,
        onError: c.destructiveForeground,
        surface: c.surface,
        onSurface: c.foreground,
      ),
      extensions: [
        sdTheme,
        buttonTheme ?? SdButtonTheme.fromSdTheme(sdTheme),
        listTheme ?? SdListTheme.fromSdTheme(sdTheme),
        dialogTheme ?? SdDialogTheme.fromSdTheme(sdTheme),
        toasterTheme ?? SdToasterTheme.fromSdTheme(sdTheme),
        navBarTheme ?? SdNavBarTheme.fromSdTheme(sdTheme),
      ],
    );
  }
}
