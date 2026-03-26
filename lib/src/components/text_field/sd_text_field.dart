import 'package:flutter/material.dart';

import '../../utils/sd_extensions.dart';

export 'sd_text_field_theme.dart';

/// A minimalist text field component.
///
/// ```dart
/// SdTextField(
///   label: 'Email',
///   hint: 'you@example.com',
///   controller: _controller,
/// )
///
/// SdTextField(
///   label: 'Password',
///   obscureText: true,
///   controller: _passController,
/// )
/// ```
class SdTextField extends StatefulWidget {
  const SdTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.errorText,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.autofocus = false,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final String? errorText;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final bool autofocus;

  @override
  State<SdTextField> createState() => _SdTextFieldState();
}

class _SdTextFieldState extends State<SdTextField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.sdTextFieldTheme;
    final bool isObscure = widget.obscureText && _obscured;

    Widget? suffix = widget.suffixIcon;
    if (widget.obscureText) {
      suffix = GestureDetector(
        onTap: () => setState(() => _obscured = !_obscured),
        child: Icon(
          _obscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: theme.iconColor,
          size: 20,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(widget.label!, style: theme.labelStyle),
          ),
        TextField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          obscureText: isObscure,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          autofocus: widget.autofocus,
          style: theme.inputStyle,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: theme.hintStyle,
            filled: true,
            fillColor: widget.enabled ? theme.fillColor : theme.fillColor.withAlpha(128),
            contentPadding: theme.contentPadding,
            prefixIcon: widget.prefixIcon != null
                ? IconTheme(
                    data: IconThemeData(color: theme.iconColor, size: 20),
                    child: widget.prefixIcon!,
                  )
                : null,
            suffixIcon: suffix != null
                ? IconTheme(
                    data: IconThemeData(color: theme.iconColor, size: 20),
                    child: suffix,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(
                color: widget.errorText != null ? theme.errorBorderColor : theme.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(
                color: widget.errorText != null ? theme.errorBorderColor : theme.focusedBorderColor,
                width: 1.5,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.borderColor.withAlpha(128)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.errorBorderColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: theme.borderRadius,
              borderSide: BorderSide(color: theme.errorBorderColor, width: 1.5),
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 4),
            child: Text(widget.errorText!, style: theme.errorStyle),
          ),
      ],
    );
  }
}
