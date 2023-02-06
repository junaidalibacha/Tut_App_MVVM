import 'package:flutter/material.dart';

import '../src/colors_manager.dart';
import 'components/appBar_theme.dart';
import 'components/card_theme.dart';
import 'components/text_theme.dart';

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    primaryColorDark: ColorManager.darkPrimary,
    primaryColorLight: ColorManager.primaryOpacity70,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.primaryOpacity70,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.grey, // accent color
    ),
    textTheme: getTextTheme(ThemeMode.light),
    appBarTheme: getAppBarTheme(),
    cardTheme: getCardTheme(ThemeMode.light),
  );
}
