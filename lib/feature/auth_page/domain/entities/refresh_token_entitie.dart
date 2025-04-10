




import 'package:vas_ods/feature/auth_page/data/models/token_model.dart' show TokenModel;

class TokenEntity extends TokenModel {
  const TokenEntity({
    required int code,
    required int id,
    required String token,
  }) : super(
    code: code,
    id: id,
    token: token,
  );
}
