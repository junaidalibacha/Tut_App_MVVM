import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_project/presentation/routes/routes.dart';
import 'package:flutter_mvvm_project/presentation/src/colors_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/strings_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/values_manager.dart';
import 'package:flutter_mvvm_project/presentation/views_models/onboarding_view_model/onboarding_provider.dart';
import 'package:flutter_mvvm_project/presentation/views_models/onboarding_view_model/onboarding_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../src/space_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final OnboardingViewModel _viewModel = OnboardingViewModel();

  @override
  void initState() {
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = Provider.of<OnboardingProvider>(context);

    return StreamBuilder<SlideViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (ctx, snapshot) {
        // print(snapshot.data!.sliderObject.title);
        return _buildBodyContent(onboardingData);
      },
    );
  }

  Widget _buildBodyContent(OnboardingProvider? slideViewObject) {
    // print(slideViewObject!.sliderObject.title);
    return Scaffold(
      // backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: slideViewObject == null
          ? Container(
              color: Colors.red,
            )
          : PageView.builder(
              controller: slideViewObject.pageController,
              itemCount: slideViewObject.getSliderData.length,
              onPageChanged: (value) => slideViewObject.onPageChanged(value),
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.all(AppSize.s8),
                child: Consumer(
                  builder: (context, value, child) => Column(
                    children: [
                      BuildSpace.virtical(AppSize.s40),
                      Text(
                        slideViewObject.getSliderData[index].title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        slideViewObject.getSliderData[index].subTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      BuildSpace.virtical(AppSize.s40),
                      SvgPicture.asset(
                          slideViewObject.getSliderData[index].image),
                    ],
                  ),
                ),
              ),
            ),
      bottomSheet: SizedBox(
        height: AppSize.s10 * 10,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  StringManager.skip,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            _getBottomSheet(slideViewObject!),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getBottomSheet(OnboardingProvider sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              // _viewModel.nextPage();
              sliderViewObject.previousePage();
              // sliderViewObject.pageController.previousPage(
              //     duration: const Duration(microseconds: 300),
              //     curve: Curves.linear);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: ColorManager.white,
            ),
          ),
          Row(
            children: List.generate(
              sliderViewObject.getSliderData.length,
              (index) => Consumer(
                builder: (ctx, value, _) => Container(
                  height: AppSize.s10,
                  width: AppSize.s10,
                  margin: const EdgeInsets.all(AppMargin.m4),
                  decoration: BoxDecoration(
                      color: sliderViewObject.currentIndex == index
                          ? ColorManager.white
                          : ColorManager.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorManager.white,
                        width: AppSize.s2,
                      )),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              sliderViewObject.currentIndex <
                      sliderViewObject.getSliderData.length - 1
                  ?
                  // _viewModel.previousPage();
                  sliderViewObject.nextPage()
                  // sliderViewObject.pageController.nextPage(
                  //     duration: const Duration(microseconds: 300),
                  //     curve: Curves.linear);
                  : Navigator.pushReplacementNamed(context, Routes.loginRoute);
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: ColorManager.white,
            ),
          ),
        ],
      ),
    );
  }
}
