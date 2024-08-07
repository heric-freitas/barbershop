import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

import '../../core/exceptions/auth_exceptions.dart';
import '../../core/fp/nil.dart';

abstract interface class UserRepository {
  Future<Either<AuthExceptions, String>> login(String email, String password);
  Future<Either<RepositoryException, UserModel>> me();

  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String name, String email, String password}) userData);
}
