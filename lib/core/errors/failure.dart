import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMsg;

  Failure({required this.errorMsg});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMsg});

  factory ServerFailure.fromDioError(DioException error) {
    switch (error.type) {

      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMsg: 'Connection Timeout With Server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMsg: 'Send Timeout With Server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMsg: 'Receive Timeout With Server');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMsg: 'BadCertificate With Server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          error.response!.statusCode!,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errorMsg: 'Request to Server Was Cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMsg: 'No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure(
            errorMsg: 'Oops There Was an Error , Please Try Again ');
    }
  }

  factory ServerFailure.fromResponse(
    int statusCode,
  ) {
    if (statusCode == 404) {
      return ServerFailure(
          errorMsg: 'Your Request was Not found, Please try later');
    } else if (statusCode >= 500) {
      return ServerFailure(
          errorMsg: 'There is a problem with server, please try later');
    } else {
      return ServerFailure(errorMsg: 'There was an error , please try again');
    }
  }
}
// class CacheFailure extends Failure {}
// class NetWorkFailure extends Failure {}
