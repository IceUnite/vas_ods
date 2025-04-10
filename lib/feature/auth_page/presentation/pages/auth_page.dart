import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vas_ods/core/resources/assets/resources.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/core/theme/button_style.dart';
import 'package:vas_ods/core/theme/theme_notifier.dart';
import 'package:vas_ods/core/theme/typography.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart';
import 'package:vas_ods/feature/auth_page/presentation/bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  static String name = AppRoute.authScreenPath;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with SingleTickerProviderStateMixin {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fieldWidth = screenWidth * 0.3 < 100 ? 100 : screenWidth * 0.3;

    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final isDarkTheme = themeNotifier.isDarkTheme;

        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.black,
              body: BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.goNamed(AppRoute.mainScreenPath);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 40,
                              top: 40,
                              left: 60,
                              right: 60,
                            ),
                            child: AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                double angle = _animationController.value * 2.0 * 3.141592653589793;
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    double maxSize = 200;
                                    double logoSize = constraints.maxWidth < maxSize ? constraints.maxWidth : maxSize;

                                    return Transform(
                                      transform: Matrix4.identity()
                                        ..setEntry(3, 2, 0.001)
                                        ..rotateY(angle),
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: logoSize,
                                        height: logoSize,
                                        child: SvgPicture.asset(
                                          ImageAssets.logo,
                                          color: AppColors.orange200,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Text(
                            'Вход',
                            style: AppTypography.font24Regular.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.white ,
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: fieldWidth,
                            child: TextFormField(
                              controller: _loginController,
                              decoration: InputDecoration(
                                hintText: 'Введите логин',
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                filled: true,
                                fillColor:Colors.grey.shade700 ,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: fieldWidth,
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Введите пароль',
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                filled: true,
                                fillColor: Colors.grey.shade700 ,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              obscureText: true,
                            ),
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: fieldWidth,
                            child: ElevatedButton(
                              style: AppButtonStyle.primaryStyleWhite,
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  CheckLoginPasswordEvent(
                                    login: _loginController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                              },
                              child: state is AuthLoading
                                  ? const CircularProgressIndicator()
                                  : Text(
                                'Войти',
                                style: AppTypography.font24Regular.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}