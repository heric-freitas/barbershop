import 'package:dw_barbershop/src/core/fp/either.dart';

import '../../core/exceptions/auth_exceptions.dart';

abstract interface class UserRepository {
  Future<Either<AuthExceptions, String>> login(String email, String password);
}
