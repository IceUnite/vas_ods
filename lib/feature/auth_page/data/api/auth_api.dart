
import 'package:vas_ods/feature/auth_page/data/models/token_model.dart' show TokenModel;

abstract class AuthApi {
  Future<TokenModel> loginCommand({
    required String userName,
    required String password,
  });

  Future<void> checkTokenOper({
    required String userId,
    required String token,
  });
}
