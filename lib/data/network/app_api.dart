import 'package:dio/dio.dart';
import 'package:flutter_mvvm_project/app/constants.dart';
import 'package:flutter_mvvm_project/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServieceClient {
  factory AppServieceClient(Dio dio, {String baseUrl}) = _AppServieceClient;

  @POST('/customers/login')
  Future<AuthResponse> login(
    @Field('email') String email,
    @Field('password') String password,
    @Field('imei') String emei,
    @Field('deviceType') String deviceType,
  );
}
