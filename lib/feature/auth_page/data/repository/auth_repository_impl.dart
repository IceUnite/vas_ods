import 'package:injectable/injectable.dart';
import 'package:vas_ods/feature/auth_page/data/api/service/auth_service_api.dart' show AuthApiDioService;
import 'package:vas_ods/feature/auth_page/domain/entities/refresh_token_entitie.dart' show TokenEntity;
import 'package:vas_ods/feature/auth_page/domain/repository/auth_repository.dart' show AuthRepository;

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({required this.authServiceApi});

  final AuthApiDioService authServiceApi;

  @override
  Future<TokenEntity> loginCommand({
    required String userName,
    required String password,
  }) async {
    final tokenModel = await authServiceApi.loginCommand(userName: userName, password: password);
    return TokenEntity(
      code: tokenModel.code,
      id: tokenModel.id,
      token: tokenModel.token,
    );
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<dynamic> refreshToken({required refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  // Новый метод для проверки токена
  @override
  Future<void> checkTokenOper({
    required String userId,
    required String token,
  }) async {
    try {
      await authServiceApi.checkTokenOper(userId: userId, token: token);
      print("Токен действителен");
    } catch (e) {
      throw Exception('Ошибка проверки токена: $e');
    }
  }
}
