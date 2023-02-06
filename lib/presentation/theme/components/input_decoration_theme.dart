import 'package:flutter/material.dart';

import '../../src/colors_manager.dart';
import '../../src/styles_manager.dart';
import '../../src/values_manager.dart';

InputDecorationTheme getInputDecoration() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.all(AppPadding.p8),
    hintStyle: TextStyleManager.regularTextStyle(
      color: ColorManager.grey1,
    ),
    labelStyle: TextStyleManager.mediumTextStyle(
      color: ColorManager.darkGrey,
    ),
    errorStyle: TextStyleManager.regularTextStyle(
      color: ColorManager.error,
    ),
    enabledBorder: OutlineInputBorderStyle.getEnabledBorder(),
    focusedBorder: OutlineInputBorderStyle.getFocusBorder(),
    errorBorder: OutlineInputBorderStyle.getErrorBorder(),
    focusedErrorBorder: OutlineInputBorderStyle.getFocusedErrorBorder(),
  );
}
