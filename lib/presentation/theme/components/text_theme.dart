import 'package:flutter/material.dart';

import '../../src/colors_manager.dart';
import '../../src/fonts_manager.dart';
import '../../src/styles_manager.dart';

TextTheme getTextTheme(ThemeMode thememode) {
  return thememode == ThemeMode.light
      ? TextTheme(
          headline1: TextStyleManager.semiBoldTextStyle(
            textColor: ColorManager.darkGrey,
            fontSize: FontSize.s16,
          ),
          subtitle1: TextStyleManager.mediumTextStyle(
            color: ColorManager.lightGrey,
            fontSize: FontSize.s14,
          ),
          subtitle2: TextStyleManager.mediumTextStyle(
            color: ColorManager.primary,
            fontSize: FontSize.s14,
          ),
          bodyText1: TextStyleManager.regularTextStyle(
            color: ColorManager.grey1,
          ),
          caption: TextStyleManager.regularTextStyle(
            color: ColorManager.grey,
          ),
        )
      : const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
          ),
          headline2: TextStyle(
            color: Colors.white,
          ),
          headline3: TextStyle(
            color: Colors.white,
            // fontSize: 35,
          ),
          headline4: TextStyle(
            color: Colors.white,
            // fontSize: 35,
            fontStyle: FontStyle.italic,
          ),
        );
}
