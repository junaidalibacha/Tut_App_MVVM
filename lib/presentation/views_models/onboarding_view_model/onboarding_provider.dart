import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm_project/domain/models/models.dart';

import '../../src/assets_manager.dart';
import '../../src/strings_manager.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  final List<SliderObject> _list = [
    SliderObject(
      StringManager.onBoardingTitle1,
      StringManager.onBoardingSubTitle1,
      AssetsImages.onboarding1,
    ),
    SliderObject(
      StringManager.onBoardingTitle2,
      StringManager.onBoardingSubTitle2,
      AssetsImages.onboarding2,
    ),
    SliderObject(
      StringManager.onBoardingTitle3,
      StringManager.onBoardingSubTitle3,
      AssetsImages.onboarding3,
    ),
  ];
  List<SliderObject> get getSliderData => [..._list];

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    // currentIndex++;
    // pageController.jumpTo(currentIndex.toDouble());
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    notifyListeners();
  }

  void previousePage() {
    // currentIndex--;
    // pageController.jumpTo(currentIndex.toDouble());
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    notifyListeners();
  }
}
