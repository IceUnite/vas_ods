import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vas_ods/core/errors/error_handler.dart' show ServerException;
import 'package:vas_ods/core/errors/exception.dart';
import 'package:vas_ods/core/errors/failure.dart';
import 'package:vas_ods/feature/auth_page/domain/entities/refresh_token_entitie.dart';
import 'package:vas_ods/feature/auth_page/domain/repository/auth_repository.dart' ;


@lazySingleton
class AuthUseCase {
  final AuthRepository authRepository;

  const AuthUseCase({required this.authRepository});

  /// Вход в систему
  Future<TokenEntity> loginCommand({
    required String userName,
    required String password,
  }) async {
    try {
      final loginCommandData = await authRepository.loginCommand(userName: userName, password: password);
      return TokenEntity(
        code: loginCommandData.code,
        id: loginCommandData.id,
        token: loginCommandData.token,
      );
    } on DioException catch (e) {
      Exception exception = ServerException(e.message.toString());
      Failure failure = ErrorHandler.handleException(exception);

      throw failure;
    }
  }

  /// Выход из системы
  Future<void> logOut() async => authRepository.logout();

  Future<void> checkToken({
    required String userId,
    required String token,
  }) async {
    try {
      await authRepository.checkToken(userId: userId, token: token);
    } on DioException catch (e) {
      Exception exception = ServerException(e.message.toString());
      Failure failure = ErrorHandler.handleException(exception);
      throw failure;
    }
  }

  /// Обновление токена
// Future<JwtTokensDTOEntity?> refreshToken({
//   required RefreshTokenEntitie refreshToken,
// }) async =>
//     authRepository.refreshToken(refreshToken: refreshToken);
}
