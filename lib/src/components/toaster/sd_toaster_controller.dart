import 'sd_toast.dart';

/// Controls the [SdToasterScope] overlay.
///
/// Obtain via `SdToasterScope.of(context)`.
abstract interface class SdToasterController {
  /// Shows a toast. Returns its unique id.
  String show(SdToast toast);

  /// Dismisses a toast by its id.
  void dismiss(String id);

  /// Dismisses all visible toasts.
  void dismissAll();
}
