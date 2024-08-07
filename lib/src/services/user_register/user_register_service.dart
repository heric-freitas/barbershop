import 'package:dw_barbershop/src/core/exceptions/service_exception.dart';
import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';

abstract class UserRegisterADMService {
  Future<Either<ServiceException, Nil>> execute(  ({String name, String email, String password}) userData);
}