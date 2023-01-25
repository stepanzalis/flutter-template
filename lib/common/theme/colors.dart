import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = gray4;
  static const Color secondary = black;
  static const Color accent = yellow;
  static const Color white = Colors.white;

  /// Color definitions
  static const Color gray1 = Color(0xffEEEFF2);
  static const Color gray2 = Color(0xff9d9da8);
  static const Color gray3 = Color(0xff626275);
  static const Color gray4 = Color(0xff363636);
  static const Color yellow = Color(0xffFAC61F);
  static const Color green = Color(0xff73c37c);
  static const Color error = Color(0xffDC0E40);
  static const Color black = Color(0xff14141F);

  static const Color lightGrey = Color(0xffeeeff2);
  static const Color scannerRoundedOverlay = Color(0xffDADADA);
  static const Color scannerOverlayColor = Color.fromRGBO(0, 0, 0, 80);

  static const Color metaGrey = Color(0xff838895);

  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
        (darker ? (hsl.lightness - value) : (hsl.lightness + value))
            .clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  static MaterialColor getMaterialColorFromColor(Color color) {
    Map<int, Color> colorShades = {
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
