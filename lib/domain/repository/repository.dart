import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_project/domain/models/models.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';

abstract class Repository {
  Future<Either<Failure, AuthResModel>> login(LoginRequest loginRequest);
}
