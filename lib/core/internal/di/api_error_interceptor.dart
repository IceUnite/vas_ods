import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:vas_ods/core/errors/api_exceptions.dart' show FailedRequestException, ServerError, UnknownException;
import 'package:vas_ods/core/errors/bot_toast.dart' show BotToastDi;


class ApiErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      final statusCode = err.response?.statusCode;

      // Обработка ошибки 422: Неверное имя пользователя или пароль
      if (statusCode == 422) {
        GetIt.I<BotToastDi>().showNotification(
          icon: null,
          title: "Неверное имя пользователя или пароль",
        );
        throw FailedRequestException(
          title: 'Ошибка',
          message: 'Неверное имя пользователя или пароль',
          requestOptions: err.requestOptions,
          error: err.error,
        );
      }

      // Обработка ошибки 500: Ошибка на сервере
      else if (statusCode == 500) {
        GetIt.I<BotToastDi>().showNotification(
          icon: null,
          title: '${err.message}',
        );
        throw ServerError(
          requestOptions: err.requestOptions,
          error: err.error,
        );
      }

      // Для других кодов ошибок, которые не покрыты
      else {
        GetIt.I<BotToastDi>().showNotification(
          icon: null,
          title: '${err.message}',
        );
        throw FailedRequestException(
          title: 'Ошибка',
          message: 'Неизвестная ошибка',
          requestOptions: err.requestOptions,
          error: err.error,
        );
      }
    } else {
      GetIt.I<BotToastDi>().showNotification(
        icon: null,
        title: '${err.message}',
      );
      throw UnknownException(
        requestOptions: err.requestOptions,
        error: err.error,
      );
    }

    return super.onError(err, handler);
  }
}
