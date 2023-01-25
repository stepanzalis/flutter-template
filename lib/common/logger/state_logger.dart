import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';

class StateLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    logDebug('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "${newValue.toString()}"
}''');
  }

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    logDebug('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "error": "${error.toString()}"
}''');
  }
}
