import 'package:flutter_mvvm_project/data/data_source/remote_data_source.dart';
import 'package:flutter_mvvm_project/data/mapper/mapper.dart';
import 'package:flutter_mvvm_project/data/network/error_handler.dart';
import 'package:flutter_mvvm_project/data/network/network_info.dart';
import 'package:flutter_mvvm_project/domain/models/models.dart';
import 'package:flutter_mvvm_project/data/request/request.dart';
import 'package:flutter_mvvm_project/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_project/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, AuthResModel>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnect) {
      try {
        // it is safe to call the API
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalResponse.success) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return left(Failure(
              response.status ?? ApiInternalResponse.failure,
              response.message ??
                  ResponseMessage.defaultError)); // Failure, Left
        }
      } catch (error) {
        return Left(ErrorHandler.handler(error).failure);
      }
    } else {
      // return connection error
      return left(
        DataSource.noInternetConnection.getFailure(),
      );
    }
  }
}
