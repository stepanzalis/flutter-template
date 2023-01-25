import 'package:template/common/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplatePage extends ConsumerStatefulWidget {
  const TemplatePage({Key? key}) : super(key: key);

  static String get routeName => AppRoutes.appBoard;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TemplatePageState();
}

class _TemplatePageState extends ConsumerState<TemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }

  @override
  void initState() {
    super.initState();
  }
}
