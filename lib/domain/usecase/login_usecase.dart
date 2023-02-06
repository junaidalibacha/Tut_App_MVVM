import 'package:flutter_mvvm_project/app/functions.dart';
import 'package:flutter_mvvm_project/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_project/data/request/request.dart';
import 'package:flutter_mvvm_project/domain/models/models.dart';
import 'package:flutter_mvvm_project/domain/repository/repository.dart';
import 'package:flutter_mvvm_project/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, AuthResModel> {
  final Repository _repository;
  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, AuthResModel>> execute(LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await getDeviceDetail();
    return await _repository.login(
      LoginRequest(
        input.email,
        input.password,
        deviceInfo.identifier,
        deviceInfo.name,
      ),
    );
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.email, this.password);
}
