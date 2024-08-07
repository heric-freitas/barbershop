import 'package:dw_barbershop/src/core/providers/app_providers.dart';
import 'package:dw_barbershop/src/services/user_register/user_register_adm_service_impl.dart';
import 'package:dw_barbershop/src/services/user_register/user_register_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_register_providers.g.dart';

@riverpod
UserRegisterADMService userRegisterADMService(UserRegisterADMServiceRef ref) =>
    UserRegisterADMServiceImpl(
        userRepository: ref.watch(userRepositoryProvider),
        userLoginService: ref.watch(userLoginServiceProvider));
