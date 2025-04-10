
import 'package:vas_ods/core/errors/error_handler.dart' show CacheException, ServerException;
import 'package:vas_ods/core/errors/failure.dart' show CacheFailure, Failure, ServerFailure;

class ErrorHandler {
  static Failure handleException(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else {
      return UnknownFailure();
    }
  }
}

class UnknownFailure extends Failure {}
