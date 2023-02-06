import 'package:flutter/material.dart';
import 'package:flutter_mvvm_project/app/dep_inj.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
