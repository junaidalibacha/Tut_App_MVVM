import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/domain/models/models.dart';
import 'package:flutter_mvvm_project/presentation/views_models/base/base_view_model.dart';

import '../../src/assets_manager.dart';
import '../../src/strings_manager.dart';

class OnboardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SlideViewObject>.broadcast();
  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;

  // List<SliderObject> get sliderData {
  //   return [..._getSliderData()];
  // }

  late List<SliderObject> _list;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();

    //* send data to view
    _postDataToView();
    print('======> start funtion called');
  }

  @override
  void nextPage() {
    // _pageController.jumpTo(_currentIndex + 1);

    _currentIndex = _currentIndex + 1;
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView(); //* sending the updated data to View
  }

  @override
  void previousPage() {
    _pageController.jumpTo(_currentIndex - 1);
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  //? Private Functions
  List<SliderObject> _getSliderData() => [
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

  //? Function for Sending Data to View
  void _postDataToView() {
    inputSliderViewObject.add(
      SlideViewObject(
        _list[_currentIndex],
        _pageController,
        _list.length,
        _currentIndex,
      ),
    );
    print('==========>Data added');
    print(_list[0].title);
  }
}

abstract class OnboardingViewModelInputs {
  //? the Data that View-Model will Recieve from View

  void nextPage();
  void previousPage();
  void onPageChanged(int index);

  //?  Stream Input
  Sink get inputSliderViewObject; //? this is the way to add Data to the Stream.
}

abstract class OnboardingViewModelOutputs {
  //? the Data/Respons that View-Model will Send to View
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SlideViewObject(
    this.sliderObject,
    this.pageController,
    this.numOfSlides,
    this.currentIndex,
  );
  SliderObject sliderObject;
  PageController pageController;
  int numOfSlides;
  int currentIndex;
}
