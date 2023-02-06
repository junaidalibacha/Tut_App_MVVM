import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mvvm_project/app/dep_inj.dart';
import 'package:flutter_mvvm_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_mvvm_project/presentation/routes/routes.dart';
import 'package:flutter_mvvm_project/presentation/src/assets_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/space_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/strings_manager.dart';
import 'package:flutter_mvvm_project/presentation/src/values_manager.dart';
import 'package:flutter_mvvm_project/presentation/views_models/login_view_model/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordeController = TextEditingController();
  final GlobalKey _formKey = GlobalKey();
  void _bind() {
    _viewModel.start();
    _userNameController.addListener(
      () => _viewModel.setUserName(_userNameController.text),
    );
    _passwordeController.addListener(
      () => _viewModel.setUserPassword(_passwordeController.text),
    );
    _viewModel.isLoggedInSuccessfullyStreamController.stream
        .listen((isSuccessLoggedIn) {
      // navigate to main screen
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.buildScreenWidget(context, _buildBodyContent(context), () {
                _viewModel.onLogin();
              }) ??
              _buildBodyContent(context);
        },
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(AssetsImages.splashLogo),
              BuildSpace.virtical(AppSize.s25),
              StreamBuilder<bool>(
                stream: _viewModel.outputIsUserNameValid,
                builder: (context, snapshot) => TextFormField(
                  controller: _userNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: StringManager.userName,
                    labelText: StringManager.userName,
                    errorText: (snapshot.data ?? true)
                        ? null
                        : StringManager.userNameError,
                  ),
                ),
              ),
              BuildSpace.virtical(AppSize.s25),
              StreamBuilder<bool>(
                stream: _viewModel.outPutIsPasswordValid,
                builder: (context, snapshot) => TextFormField(
                  controller: _passwordeController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: StringManager.password,
                    labelText: StringManager.password,
                    errorText: (snapshot.data ?? true)
                        ? null
                        : StringManager.passwordError,
                  ),
                ),
              ),
              BuildSpace.virtical(AppSize.s25),
              StreamBuilder<bool>(
                stream: _viewModel.outPutIsAllInputsValid,
                builder: (context, snapshot) => ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () {
                          _viewModel.onLogin();
                        }
                      : null,
                  child: const Text(StringManager.login),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      );
                    },
                    child: Text(
                      StringManager.forgetPassword,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.registerRoute,
                      );
                    },
                    child: Text(
                      StringManager.registerText,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
