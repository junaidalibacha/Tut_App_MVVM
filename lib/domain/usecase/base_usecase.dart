import 'package:dartz/dartz.dart';
import 'package:flutter_mvvm_project/data/network/failure.dart';

abstract class BaseUseCase<In, out> {
  Future<Either<Failure, out>> execute(In input);
}
