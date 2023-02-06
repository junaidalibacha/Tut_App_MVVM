import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm_project/app/app_prefs.dart';
import 'package:flutter_mvvm_project/app/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String appJson = 'application/json';
const String contentType = 'content-type';
const String accept = 'accept';
const String authorization = 'authorization';
const String defaultLang = 'langauge';

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);
  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60 * 1000; // = 1 min
    String language = await _appPreferences.getAppLanguage();

    Map<String, String> headers = {
      contentType: appJson,
      accept: appJson,
      authorization: Constant.token,
      defaultLang: language,
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    if (kReleaseMode) {
      debugPrint('release mode no logs');
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
