import 'package:flutter/material.dart';

/// Find outs all possible locales that can be used and returns the first one
///
/// [phoneLocales] Phone locales are all locales that are supported by user's phone
/// [supportedLocales] Locales that are supported by an app
///
/// return The intersection between these two lists if is found, otherwise [defaultLocale] is returned
Locale findSupportedLanguage({
  required List<Locale> phoneLocales,
  required List<Locale> supportedLocales,
  Locale defaultLocale = const Locale("en"),
}) {
  assert(phoneLocales.isNotEmpty, 'Phone locales should not be empty!');

  List<List<Locale>> allLocales = [phoneLocales, supportedLocales];
  final diffLocales = _intersection(allLocales);
  return diffLocales.isNotEmpty ? diffLocales.first : defaultLocale;
}

/// Shows all same items from arrays
///
/// From given [iterables] list [[1,2], [2,3,4]] it finds all common items ->
/// in this example case, just [2]
List<Locale> _intersection<T>(Iterable<Iterable<Locale>> iterables) {
  return iterables.map((e) => e.toSet()).reduce((a, b) => a.intersection(b)).toList();
}
