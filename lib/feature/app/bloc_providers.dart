
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vas_ods/feature/auth_page/presentation/bloc/auth_bloc.dart' show AuthBloc;
import 'package:vas_ods/feature/main_page/presentation/bloc/profile_bloc.dart' show ProfileBloc;



List<BlocProvider> buildListProviders({required GetIt locator}) {
  return <BlocProvider>[
    BlocProvider<ProfileBloc>(
      create: (context) => locator<ProfileBloc>(),
    ),
    BlocProvider<AuthBloc>(
      create: (context) => locator<AuthBloc>(),
    ),

  ];
}
