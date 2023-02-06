import 'package:flutter_mvvm_project/data/network/app_api.dart';
import 'package:flutter_mvvm_project/data/request/request.dart';
import 'package:flutter_mvvm_project/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServieceClient _appServieceClient;
  RemoteDataSourceImplementer(this._appServieceClient);
  @override
  Future<AuthResponse> login(LoginRequest loginRequest) async {
    return await _appServieceClient.login(
      loginRequest.email,
      loginRequest.password,
      loginRequest.imei,
      loginRequest.deviceType,
    );
  }
}
