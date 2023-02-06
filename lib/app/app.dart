import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/presentation/routes/routes.dart';
import 'package:flutter_mvvm_project/presentation/theme/theme_manager.dart';
import 'package:flutter_mvvm_project/presentation/views_models/onboarding_view_model/onboarding_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp._internal(); //private Named Constructor
  static const MyApp instance = MyApp._internal(); //single instance (singleton)
  factory MyApp() => instance; //factory constructor for the class instance

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => OnboardingProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getAppTheme(),
        onGenerateRoute: RoutesGenerator.getRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}
