import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/dep_inj.dart';
import 'package:flutter_mvvm_project/presentation/src/strings_manager.dart';

import '../views/forgot_password/forgot_password.dart';
import '../views/login/login.dart';
import '../views/onboarding/onboarding.dart';
import '../views/register/register.dart';
import '../views/splash/splash.dart';

class Routes {
  static const String splashRoute = '/';
  static const String onBoardingRoute = '/onBoarding';
  static const String registerRoute = '/register';
  static const String loginRoute = '/login';
  static const String forgotPassRoute = '/forgotPassword';
  static const String mainRoute = '/mainRoute';
  static const String storeDetailsRoute = '/storeDetails';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLogin();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPassRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      // case RoutesManager.storeDetailsRoute:
      //   return MaterialPageRoute(builder: (_) => const StoreDetailView());
    }
    return _undefinedRoute();
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.undefinedRoute),
        ),
        body: const Center(
          child: Text(StringManager.noRouteFound),
        ),
      ),
    );
  }
}
