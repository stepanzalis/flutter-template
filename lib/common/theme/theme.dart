import 'package:template/common/theme/colors.dart';
import 'package:template/common/theme/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.black,
      ),
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.black,
        secondary: AppColors.white,
        background: AppColors.black,
      ),
      backgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      textTheme: TextThemes.darkTextTheme,
      primaryTextTheme: TextThemes.primaryTextTheme,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.black,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        toolbarHeight: 50,
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      textTheme: TextThemes.textTheme,
      backgroundColor: AppColors.white,
      primaryTextTheme: TextThemes.primaryTextTheme,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.white,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColors.white,
      ),
    );
  }
}

class TextThemes {
  static TextTheme get textTheme {
    return const TextTheme(
      bodyText1: AppTextStyles.bodyLg,
      bodyText2: AppTextStyles.body,
      subtitle1: AppTextStyles.bodySm,
      subtitle2: AppTextStyles.bodyXs,
      headline1: AppTextStyles.h1,
      headline2: AppTextStyles.h2,
      headline3: AppTextStyles.h3,
      headline4: AppTextStyles.h4,
    );
  }

  static TextTheme get darkTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.white),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.white),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.white),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.white),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.white),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.white),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.white),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.white),
      headline5: AppTextStyles.h5.copyWith(color: AppColors.white),
    );
  }

  static TextTheme get primaryTextTheme {
    return TextTheme(
      bodyText1: AppTextStyles.bodyLg.copyWith(color: AppColors.black),
      bodyText2: AppTextStyles.body.copyWith(color: AppColors.black),
      subtitle1: AppTextStyles.bodySm.copyWith(color: AppColors.black),
      subtitle2: AppTextStyles.bodyXs.copyWith(color: AppColors.black),
      headline1: AppTextStyles.h1.copyWith(color: AppColors.black),
      headline2: AppTextStyles.h2.copyWith(color: AppColors.black),
      headline3: AppTextStyles.h3.copyWith(color: AppColors.black),
      headline4: AppTextStyles.h4.copyWith(color: AppColors.black),
      headline5: AppTextStyles.h5.copyWith(color: AppColors.white),
    );
  }
}
