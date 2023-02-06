import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/constants.dart';
import 'package:flutter_mvvm_project/presentation/src/assets_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/colors_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/strings_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/styles_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // Pop-up States
  popupLoadingState,
  popupErrorState,

  // Full Screen States
  fullScreenLoadingState,
  fullScreenErrorState,

  // the UI of the Screen
  contentScreenState,

  // Empty view, when No data receive from API side
  emptyScreenState,
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  // final Failure failure;
  final String message;
  final String title;
  final Function? retryActionFunc;
  const StateRenderer({
    super.key,
    required this.stateRendererType,
    // Failure? failure,
    String? message,
    String? title,
    this.retryActionFunc,
  })  : message = message ?? StringManager.loading,
        title = title ?? kEmpty;
  // failure = failure ?? DefaultFailure();

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopDialog(
            context, [_buildAnimatedImage(AssetsJson.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopDialog(context, [
          _buildAnimatedImage(AssetsJson.error),
          _buildMessage(message),
          _buildRetryButton(context, StringManager.ok),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _buldItemsInColumn([
          _buildAnimatedImage(AssetsJson.loading),
          _buildMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _buldItemsInColumn([
          _buildAnimatedImage(AssetsJson.error),
          _buildMessage(message),
          _buildRetryButton(context, StringManager.retryAgain)
        ]);
      case StateRendererType.contentScreenState:
        return Container();
      case StateRendererType.emptyScreenState:
        return _buldItemsInColumn([
          _buildAnimatedImage(AssetsJson.empty),
          _buildMessage(message),
        ]);
      default:
        return Container();
    }
  }

  Widget _buldItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _buildAnimatedImage(String jsonImage) {
    return SizedBox(
      height: AppSize.s25 * 4,
      width: AppSize.s25 * 4,
      child: Lottie.asset(jsonImage), // json Image
    );
  }

  Widget _buildMessage(String message) {
    return Text(
      message,
      style: TextStyleManager.mediumTextStyle(fontSize: AppSize.s16),
    );
  }

  Widget _buildRetryButton(BuildContext context, String btnTitle) {
    return ElevatedButton(
      onPressed: () {
        if (stateRendererType == StateRendererType.fullScreenErrorState) {
          retryActionFunc?.call(); // for reloading the API again

        } else {
          Navigator.of(context).pop();
        } // for dismissing the PopUp
      },
      child: Text(btnTitle),
    );
  }
}

Widget _getPopDialog(BuildContext context, List<Widget> children) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.s14),
    ),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(AppSize.s14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: AppSize.s12,
            offset: Offset(AppSize.s0, AppSize.s12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    ),
  );
}

// Widget _getDialogContent(BuildContext context, List<Widget> children) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: children,
//   );
// }
