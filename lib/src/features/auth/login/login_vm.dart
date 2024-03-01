import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/exceptions/service_exceptions.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/providers/app_providers.dart';
import 'package:dw_barbershop/src/features/auth/login/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();
    final loginService = ref.watch(userLoginServiceProvider);
    final result = await loginService.login(email, password);
    switch (result) {
      case Failure(exception: ServiceExceptions(:final message)):
        state = state.copyWith(
          state: LoginStateStatus.error,
          messageError: () => message,
        );
      case Success():
    }
    loaderHandler.close();
    // result.when(failure: (exception: ServiceExceptions(:final)) {

    // }, success: (_) {});
  }
}
