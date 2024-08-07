import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/app_theme.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_nav_global_key.dart';
import 'package:dw_barbershop/src/core/ui/widgets/loader.dart';
import 'package:dw_barbershop/src/features/auth/login/login_page.dart';
import 'package:dw_barbershop/src/features/auth/register/user_register_page.dart';
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
          navigatorKey: BarbershopNavGlobalKey.instance.navKey,
          navigatorObservers: [p0],
          routes: {
            '/': (_) => const SplashPage(),
            '/auth/login' : (_) => const LoginPage(),
            '/auth/register/user' : (_) => const UserRegisterPage(),
            '/auth/register/barbershop' : (_) => const Text('barbershop page'),
            '/home/adm' : (_) => const Text('adm'),
            '/home/employee' : (_) => const Text('employee'),
          },
        );
      },
    );
  }
}
