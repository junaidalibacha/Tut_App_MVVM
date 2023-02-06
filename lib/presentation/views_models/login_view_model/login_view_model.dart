import 'dart:async';

import 'package:flutter_mvvm_project/domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm_project/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter_mvvm_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_mvvm_project/presentation/views_models/base/base_view_model.dart';
import 'package:flutter_mvvm_project/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController.broadcast();
  final StreamController _passwordStreamController =
      StreamController.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController.broadcast();
  final StreamController isLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject('', '');
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

//
//* Inputs
//
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    // view tells state-renderer, please show the content of the screen.
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  onLogin() async {
    inputState.add(
      LoadingState(stateRendererType: StateRendererType.popupLoadingState),
    );
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
      (failure) => {
        // left -> failure
        inputState.add(
            ErrorState(StateRendererType.popupErrorState, failure.message)),
      },
      (data) => {
        // right -> success (data)
        inputState.add(ContentState()),

        // navigate to main screen after login
        isLoggedInSuccessfullyStreamController.add(true),
      },
    );
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    // data class operation same as kotlin
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
    // data class operation same as kotlin
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

//
//* Outputs
//
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _userNameValidator(userName));

  @override
  Stream<bool> get outPutIsPasswordValid => _passwordStreamController.stream
      .map((password) => _passwordValidator(password));

  @override
  Stream<bool> get outPutIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map(
        (_) => _isAllInputsValid(),
      );

//
//* Private functions
//

  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _passwordValidator(String password) {
    return password.isNotEmpty;
  }

  bool _userNameValidator(String userName) {
    return userName.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _userNameValidator(loginObject.userName) &&
        _userNameValidator(loginObject.password);
  }
}

abstract class LoginViewModelInputs {
  // here will be 3 functions and 2 sinks

  // the 3 functions for actions;
  setUserName(String userName);
  setUserPassword(String password);
  onLogin();

  // 3 sinks for streams
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outPutIsPasswordValid;
  Stream<bool> get outPutIsAllInputsValid;
}
