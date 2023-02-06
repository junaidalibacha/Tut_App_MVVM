import 'package:dio/dio.dart';
import 'package:flutter_mvvm_project/data/network/failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbiden,
  unAuthorized,
  notFound,
  internalServerError,
  defaultError,
  connectionTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handler(dynamic error) {
    if (error is DioError) {
      // dio error, so it is from response of API.
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectionTimeOut.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeOut.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeOut.getFailure();

      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbiden:
            return DataSource.forbiden.getFailure();
          case ResponseCode.unAuthorized:
            return DataSource.unAuthorized.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }

      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();

      case DioErrorType.other:
        return DataSource.defaultError.getFailure();
    }
  }
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbiden:
        return Failure(ResponseCode.forbiden, ResponseMessage.forbiden);

      case DataSource.unAuthorized:
        return Failure(ResponseCode.unAuthorized, ResponseMessage.unAuthorized);

      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);

      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);

      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);

      case DataSource.connectionTimeOut:
        return Failure(
            ResponseCode.connectionTimeOut, ResponseMessage.connectionTimeOut);

      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);

      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);

      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);

      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);

      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);

      default:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}

class ResponseCode {
  // API server codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no data
  static const int badRequest = 400; // failure, API rejected the request
  static const int forbiden = 403; // failure, API rejected the request
  static const int unAuthorized = 401; // failure, user is not authorized
  static const int notFound = 404; // failure, API url is not found
  static const int internalServerError =
      500; // failure, crash happend in server side

  // local serer codes
  static const int defaultError = -1;
  static const int connectionTimeOut = -2;
  static const int cancel = -3;
  static const int receiveTimeOut = -4;
  static const int sendTimeOut = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API server codes
  static const String success = 'succes'; // success with data
  static const String noContent =
      'success with no content'; // success with no data
  static const String badRequest =
      'Bad request, try again later'; // failure, API rejected the request
  static const String forbiden =
      'forbiden request, try again later'; // failure, API rejected the request
  static const String unAuthorized =
      'user is unAuthorized, please authenticate'; // failure, user is not authorized
  static const String notFound =
      'Url is not found, please check Url'; // failure, API url is not found
  static const String internalServerError =
      'something went wrong, try again later';
  // failure, crash happend in server side

  // local serer codes
  static const String defaultError = 'something went wrong, try again later';
  static const String connectionTimeOut = 'connection timeOut, try again later';
  static const String cancel = 'request is cancelld, try again later ';
  static const String receiveTimeOut = 'timeOut error, try again later';
  static const String sendTimeOut = 'timeOut error, try again later';
  static const String cacheError = 'cache error, try again later';
  static const String noInternetConnection =
      'please check your internet connection';
}

class ApiInternalResponse {
  static const int success = 0;
  static const int failure = 1;
}
