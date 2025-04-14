// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../feature/auth_page/data/api/service/auth_service_api.dart'
    as _i785;
import '../../../feature/auth_page/data/repository/auth_repository_impl.dart'
    as _i458;
import '../../../feature/auth_page/domain/repository/auth_repository.dart'
    as _i472;
import '../../../feature/auth_page/domain/usecases/auth_usecase.dart' as _i199;
import '../../../feature/auth_page/presentation/bloc/auth_bloc.dart' as _i185;
import '../../../feature/main_page/data/api/service/order_service_api.dart'
    as _i1055;
import '../../../feature/main_page/data/repository/order_repository_impl.dart'
    as _i230;
import '../../../feature/main_page/domain/repository/order_repository.dart'
    as _i48;
import '../../../feature/main_page/domain/usecases/order_usecase.dart' as _i290;
import '../../../feature/main_page/presentation/bloc/order_bloc.dart' as _i758;
import '../../errors/bot_toast.dart' as _i959;
import 'sl.dart' as _i581;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i959.BotToastDi>(() => _i959.BotToastDi());
  gh.lazySingleton<_i785.AuthApiDioService>(
      () => _i785.AuthApiDioService(gh<_i361.Dio>()));
  gh.lazySingleton<_i1055.OrderApiDioService>(
      () => _i1055.OrderApiDioService(gh<_i361.Dio>()));
  gh.lazySingleton<_i48.OrderRepository>(() => _i230.OrderRepositoryImpl(
      orderServiceApi: gh<_i1055.OrderApiDioService>()));
  gh.lazySingleton<_i290.OrderUseCase>(
      () => _i290.OrderUseCase(orderRepository: gh<_i48.OrderRepository>()));
  gh.lazySingleton<_i758.OrderBloc>(
      () => _i758.OrderBloc(orderUseCase: gh<_i290.OrderUseCase>()));
  gh.lazySingleton<_i472.AuthRepository>(() =>
      _i458.AuthRepositoryImpl(authServiceApi: gh<_i785.AuthApiDioService>()));
  gh.lazySingleton<_i199.AuthUseCase>(
      () => _i199.AuthUseCase(authRepository: gh<_i472.AuthRepository>()));
  gh.lazySingleton<_i185.AuthBloc>(
      () => _i185.AuthBloc(authUseCase: gh<_i199.AuthUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i581.RegisterModule {}
