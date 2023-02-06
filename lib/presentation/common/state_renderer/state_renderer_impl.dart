import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/constants.dart';
import 'package:flutter_mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_mvvm_project/presentation/src/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading State (Popup, Full Screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? StringManager.loading;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (Popup, Full Screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content state
class ContentState extends FlowState {
  ContentState();
  @override
  String getMessage() => kEmpty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

// Empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget buildScreenWidget(
    BuildContext context,
    Widget screenContent,
    Function retryActionFunction,
  ) {
    // ignore: unnecessary_this
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());
            // return the UI content of screen
            return screenContent;
          } else // StateRenderType.fullScreenLoadingState
          {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunc: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());
            // return the UI content of screen
            return screenContent;
          } else // StateRenderType.fullScreenLoadingState
          {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunc: retryActionFunction,
            );
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return screenContent;
        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunc: retryActionFunction,
          );
        }
      default:
        {
          return screenContent;
        }
    }
  }

  void showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunc: () {},
        ),
      ),
    );
  }

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;
}
