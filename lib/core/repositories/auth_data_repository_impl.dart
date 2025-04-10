import 'dart:async';

import 'package:vas_ods/core/repositories/auth_data_repository.dart' show AuthDataRepository;
import 'package:vas_ods/core/utils/shared_preference.dart' show SharedPrefsRawProvider;

import '../../main.dart' show prefs;




class AuthDataRepositoryImpl implements AuthDataRepository {
  SharedPrefsRawProvider sharedPrefsRawProvider = SharedPrefsRawProvider(prefs);
  // Stream<RefreshTokenResult>? _streamRefreshTokenResult;

  @override
  Future<void> deleteTokenAccess() {
    // TODO: implement deleteTokenAccess
    throw UnimplementedError();
  }

  // @override
  // Future<JwtTokensModel?> getTokenAccess() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final jsonString = prefs.getString(SharedKeyWords.jwtTokensModelDTOKey);
  //   if (jsonString == null) return null;
  //   final data = JwtTokensModel.fromJsonka(jsonDecode(jsonString));
  //   _jwtTokensModel = data;
  //   return JwtTokensModel.fromJsonka(jsonDecode(jsonString));
  // }

  // @override
  // void saveTokenAccess(JwtTokensModel jwtTokensDTOModel) {
  //   token.value = jwtTokensDTOModel;
  //   final jsonString = jsonEncode(jwtTokensDTOModel.toJson());
  //   _jwtTokensModel = token.value;
  //   sharedPrefsRawProvider.setString(SharedKeyWords.jwtTokensModelDTOKey, jsonString);
  // }

  // @override
  // Future<JwtTokensModel> updateTokenAccess(JwtTokensModel jwtTokensDTOModel) {
  //   // TODO: implement updateTokenAccess
  //   throw UnimplementedError();
  // }
  //
  // void setRefreshTokenResultStream(Stream<RefreshTokenResult> streamRefreshTokenResult) {
  //   _streamRefreshTokenResult = streamRefreshTokenResult;
  // }
  //
  // @override
  // ReferenceWrapper<JwtTokensModel?> get token => ReferenceWrapper<JwtTokensModel?>(value: jwtTokensModels);
  //
  // @override
  // // TODO: implement refreshTokenStream
  // Stream<RefreshTokenResult>? get refreshTokenStream => _streamRefreshTokenResult;
  //
  // @override
  // JwtTokensModel? get jwtTokensModels => _jwtTokensModel;
}
