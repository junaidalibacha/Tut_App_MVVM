import 'package:flutter/material.dart';

import '../../src/colors_manager.dart';
import '../../src/styles_manager.dart';
import '../../src/values_manager.dart';

class GetButtonTheme {
  static ElevatedButtonThemeData elevatedButtonTheme(ThemeMode themeMode) {
    return themeMode == ThemeMode.light
        ? ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              textStyle: TextStyleManager.regularTextStyle(
                color: ColorManager.white,
              ),
            ),
          )
        : ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: ColorManager.darkGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              textStyle: TextStyleManager.regularTextStyle(
                color: ColorManager.white,
              ),
            ),
          );
  }

  static OutlinedButtonThemeData outlineButtonTheme(ThemeMode themeMode) {
    return themeMode == ThemeMode.light
        ? OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              // backgroundColor: Colors.amber,
              foregroundColor: Colors.black87,
            ),
          )
        : OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              // backgroundColor: Colors.blueGrey,
              foregroundColor: Colors.white70,
            ),
          );
  }

  static ButtonThemeData appButtonTheme() {
    return ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: ColorManager.primary,
      disabledColor: ColorManager.grey1,
      splashColor: ColorManager.primaryOpacity70,
    );
  }
}
