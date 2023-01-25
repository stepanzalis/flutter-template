import 'dart:io';

import 'package:template/common/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Info dialog with one positive button
class PlatformInfoDialog extends StatelessWidget {
  final String title;
  final String desc;
  final String? buttonTitle;
  final VoidCallback? onClick;

  const PlatformInfoDialog({
    required this.title,
    required this.desc,
    this.buttonTitle,
    this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: onClick ?? Navigator.of(context).pop,
                child: Text(
                  buttonTitle ?? context.translate().core.ok,
                ),
              ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              TextButton(
                onPressed: onClick ?? Navigator.of(context).pop,
                child: Text(
                  buttonTitle ?? context.translate().core.ok,
                ),
              )
            ],
          );
  }
}

/// Info dialog with two buttons
class PlatformActionDialog extends StatelessWidget {
  final String title;
  final String desc;
  final String negativeButtonTitle;
  final String positiveButtonTitle;
  final VoidCallback onPositiveClick;

  const PlatformActionDialog({
    required this.title,
    required this.desc,
    required this.positiveButtonTitle,
    required this.onPositiveClick,
    required this.negativeButtonTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              CupertinoDialogAction(
                onPressed: Navigator.of(context).pop,
                child: Text(negativeButtonTitle),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: onPositiveClick,
                child: Text(positiveButtonTitle),
              ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(desc),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: Text(negativeButtonTitle),
              ),
              TextButton(
                onPressed: onPositiveClick,
                child: Text(positiveButtonTitle),
              )
            ],
          );
  }
}
