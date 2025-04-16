import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vas_ods/feature/auth_page/presentation/bloc/auth_bloc.dart' show AuthBloc;
import 'package:vas_ods/feature/main_page/presentation/bloc/order_bloc.dart';

import '../main_page/presentation/cubit/order_cubit.dart';

List<BlocProvider> buildListProviders({required GetIt locator}) {
  return <BlocProvider>[
    BlocProvider<OrderBloc>(
      create: (context) => locator<OrderBloc>(),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => locator<AuthBloc>(),
    ),
    BlocProvider<OrderCubit>(
      create: (context) => locator<OrderCubit>(),
    ),
  ];
}
