import 'package:flutter/material.dart';

import '../../src/colors_manager.dart';
import '../../src/fonts_manager.dart';
import '../../src/styles_manager.dart';
import '../../src/values_manager.dart';

AppBarTheme getAppBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    color: ColorManager.primary,
    shadowColor: ColorManager.primaryOpacity70,
    elevation: AppSize.s4,
    titleTextStyle: TextStyleManager.regularTextStyle(
      color: ColorManager.white,
      fontSize: FontSize.s16,
    ),
  );
}
