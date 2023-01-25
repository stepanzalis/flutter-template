import 'package:template/common/localization/localization.dart';
import 'package:template/ui/base/dialogs.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  /// Generated localization shortcuts
  AppLocalizationsData translate() {
    return Localizations.of<AppLocalizationsData>(this, AppLocalizationsData)!;
  }

  /// Returns if device has any kind of notch
  bool hasNotch() {
    return MediaQuery.of(this).viewPadding.top > 30;
  }

  /// Returns if device has any kind of notch
  bool isTablet() {
    return MediaQuery.of(this).size.width > 600;
  }

  /// General snackbar with title
  void showSnackbar(String title) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: Theme.of(this).textTheme.bodyText2,
        ),
      ),
    );
  }

  /// Show platform adaptive info dialog
  ///
  /// to see more [PlatformInfoDialog]
  void showInfoDialog(
    String title,
    String description, [
    VoidCallback? onClick,
  ]) async {
    await showDialog(
      context: this,
      builder: (context) {
        return PlatformInfoDialog(
          title: title,
          desc: description,
          onClick: onClick ?? Navigator.of(context).pop,
        );
      },
    );
  }

  /// Show platform adaptive action dialog
  ///
  /// to see more [PlatformActionDialog]
  Future<void> showActionDialog({
    required String title,
    required String description,
    required String negativeButtonTitle,
    required String positiveButtonTitle,
    required VoidCallback onPositiveClick,
  }) async {
    await showDialog(
      context: this,
      builder: (context) {
        return PlatformActionDialog(
          title: title,
          desc: description,
          negativeButtonTitle: negativeButtonTitle,
          positiveButtonTitle: positiveButtonTitle,
          onPositiveClick: onPositiveClick,
        );
      },
    );
  }
}
