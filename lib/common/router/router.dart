import 'package:flutter/material.dart';
import 'package:template/common/constants/routes.dart';
import 'package:template/common/env/env_config.dart';
import 'package:template/ui/feature/board/app_board_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: TemplatePage.routeName,
    debugLogDiagnostics: EnvConfig.isTestEnvironment,
    routes: _routes,
    errorBuilder: (context, _) => const Text("Error"),
  );
});

/// All available routes
List<GoRoute> get _routes => [
      GoRoute(
        name: AppRouteNames.appBoard,
        path: TemplatePage.routeName,
        builder: (context, _) => const TemplatePage(),
      ),
    ];
