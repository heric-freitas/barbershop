import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/ui/widgets/loader.dart';
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
          navigatorObservers: [p0],
          routes: {
            '/': (_) => const SplashPage(),
          },
        );
      },
    );
  }
}
