import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:dw_barbershop/src/services/user_register/user_register_service.dart';
import 'package:dw_barbershop/src/services/users_login/user_login_service.dart';

class UserRegisterADMServiceImpl implements UserRegisterADMService {
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  UserRegisterADMServiceImpl(
      {required this.userRepository, required this.userLoginService});
  @override
  Future<Either<ServiceException, Nil>> execute(
      ({String email, String name, String password}) userData) async {
    final result = await userRepository.registerAdmin(userData);
    return result.when(
      failure: (exception) => Failure(ServiceException(message: exception.message)),
      success: (value) {
        return userLoginService.login(userData.email, userData.password);
      },
    );
  }
}
