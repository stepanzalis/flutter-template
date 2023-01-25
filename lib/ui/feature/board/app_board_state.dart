import 'package:flutter/foundation.dart';

/// Indicates what listener should route to
enum RedirectPage {
  none,
  home;
}

@immutable
class TemplateState {
  final RedirectPage redirectPage;

  const TemplateState(this.redirectPage);
  factory TemplateState.initial() => const TemplateState(RedirectPage.none);

  @override
  String toString() => 'DashboardState(redirectPage: $redirectPage';
}
