import 'package:template/common/result/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'extensions.dart';

extension AsyncValueUI<T> on AsyncValue<Result<T>> {
  bool get isLoading => this is AsyncLoading<void>;

  // show a snackbar on error only
  void showSnackBarOnError(BuildContext context) => whenOrNull(
        error: (result, _) => showDialogFromError(context, result),
        data: (result) {
          result.maybeMap(
            error: (error) => showDialogFromError(context, result),
            orElse: () {}, // ignored
          );
        },
      );
}

// for now ignore error types, but can react for specific error types
void showDialogFromError(BuildContext context, Object result) {
  if (result is Result) {
    result.maybeWhen(
      error: (error) {
        error.failure.maybeWhen(
          noInternetConnection: () {
            context.showSnackbar("No internet. Try again later.");
          },
          serverError: (String? title, String? message, int? code) {
            _showServerError(title, message, code, context);
          },
          orElse: () => _showSomethingWentWrong(context),
        );
      },
      orElse: () {},
    );
  }
}

/// Show error [Snackbar]
void _showServerError(
  String? title,
  String? message,
  int? code,
  BuildContext context,
) {
  final safeTitle = title?.orEmpty();
  final safeMessage = message?.orEmpty();
  context.showSnackbar("$safeTitle \n$safeMessage");
}

// General error [Snackbar]
void _showSomethingWentWrong(BuildContext context) => context.showSnackbar("Something went wrong");
