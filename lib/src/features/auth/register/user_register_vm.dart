import 'package:asyncstate/asyncstate.dart';
import 'package:dw_barbershop/src/core/providers/app_providers.dart';
import 'package:dw_barbershop/src/features/auth/register/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_vm.g.dart';

enum UserRegisterStateStatus { initial, success, error }

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final userRegisterService = ref.watch(userRegisterADMServiceProvider);

    final userData = (
      name: name,
      email: email,
      password: password,
    );

    final result = await userRegisterService.execute(userData).asyncLoader();
    result.when(failure: (exception) {
      state = UserRegisterStateStatus.error;
    }, success: (_) {
      ref.invalidate(getMeProvider);
      state = UserRegisterStateStatus.success;
    });
    
  }
}
