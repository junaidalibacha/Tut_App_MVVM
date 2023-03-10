import 'package:flutter_mvvm_project/presentation/src/langauge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String langPrefsKey = 'Lang-Prefs-Key';

class AppPreferences {
  final SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(langPrefsKey);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }
}
