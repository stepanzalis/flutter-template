import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/common/constants/constants.dart';
import 'package:template/common/localization/locale_finder.dart';

void main() {
  test(
    'locale from subtag matches from constructor',
    () {
      final englishLocale = Locale("en");
      final locale = Locale.fromSubtags(languageCode: "en");
      expect(locale, englishLocale);
    },
  );

  test(
    'locale should be German when only German is available',
    () {
      final defaultLang = Locale("en");

      final phoneLocales = [Locale("en"), Locale("de")];
      final supportedLocales = [Locale("de")];

      final locale = findSupportedLanguage(
        phoneLocales: phoneLocales,
        supportedLocales: supportedLocales,
      );

      expect(locale, Locale.fromSubtags(languageCode: "de"));
    },
  );

  test(
    'default locale is English when no language is supported by phone',
    () {
      final defaultLang = Locale("en");
      final phoneLocales = [Locale("vi"), Locale("phi")];
      final supportedLocales = [Locale("en"), Locale("de")];

      final locale = findSupportedLanguage(
        phoneLocales: phoneLocales,
        supportedLocales: supportedLocales,
        defaultLocale: defaultLang,
      );
      expect(locale, defaultLang);
    },
  );

  test(
    'default locale is set and returned when no language is supported by phone',
    () {
      final defaultLang = Locale("en");

      final phoneLocales = [Locale("vi"), Locale("phi")];
      final supportedLocales = [Locale("en"), Locale("de")];

      final locale = findSupportedLanguage(
        phoneLocales: phoneLocales,
        supportedLocales: supportedLocales,
      );
      expect(locale, defaultLang);
    },
  );
}
