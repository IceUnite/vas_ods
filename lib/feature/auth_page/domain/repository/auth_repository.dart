
import 'package:vas_ods/feature/auth_page/domain/entities/refresh_token_entitie.dart' show TokenEntity;

abstract class AuthRepository {
  Future<TokenEntity> loginCommand({
    required String userName,
    required String password,
  });

  // Для обновления токена (если понадобится раскомментировать)
  // Future<JwtTokensDTOEntity?> refreshToken({
  //   required RefreshTokenEntitie refreshToken,
  // });

  Future<void> logout();

  // Новый метод для проверки токена
  Future<void> checkToken({
    required String userId,
    required String token,
  });
}
