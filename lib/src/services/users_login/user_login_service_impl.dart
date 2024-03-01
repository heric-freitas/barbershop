import 'package:dw_barbershop/src/core/constants/local_storage_constants.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';

import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/repositories/user/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/service_exceptions.dart';
import './user_login_service.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;

  UserLoginServiceImpl({required this.userRepository});

  @override
  Future<Either<ServiceExceptions, Nil>> login(
      String email, String password) async {
    final result = await userRepository.login(email, password);
    return result.when(
      success: (value) async {
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageConstants.accessToken, value);
        return Success(nil);
      },
      failure: (exception) =>
          Failure(ServiceExceptions(message: exception.message)),
    );
  }
}
