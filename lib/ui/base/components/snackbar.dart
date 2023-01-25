import 'package:template/common/extensions/extensions.dart';
import 'package:template/common/theme/colors.dart';
import 'package:template/common/theme/padding.dart';
import 'package:flutter/material.dart';

/// Scanning can be at two states [ToastStyle.error] and [ToastStyle.success]
class ToastStyle {
  factory ToastStyle.success(
    String description,
    BuildContext context,
  ) =>
      ToastStyle(
        background: AppColors.green,
        foreground: AppColors.black,
        title: context.translate().scan.success.title,
        description: description,
      );

  factory ToastStyle.error(BuildContext context) => ToastStyle(
        background: AppColors.error,
        foreground: AppColors.white,
        title: context.translate().scan.failed.title,
        description: context.translate().scan.failed.description,
      );

  const ToastStyle({
    required this.background,
    required this.foreground,
    required this.title,
    required this.description,
  });

  final Color background;
  final Color foreground;
  final String title;
  final String description;
}

/// Custom toast
class CorpToast extends StatelessWidget {
  final ToastStyle style;
  const CorpToast(this.style, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: style.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              style.title,
              style: Theme.of(context).textTheme.headline4?.copyWith(color: style.foreground),
            ),
            const SizedBox(height: spacingS),
            Text(
              style.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: style.foreground),
            ),
          ],
        ),
      ),
    );
  }
}
