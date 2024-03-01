import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/app_theme.dart';
import 'package:dw_barbershop/src/core/ui/widgets/loader.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const Loader(),
      builder: (p0) {
        return MaterialApp(
          title: 'DW BARBERSHOP',
          theme: AppTheme.themeData,
          navigatorObservers: [p0],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login' : (_) => const LoginPage(),
          },
        );
      },
    );
  }
}
