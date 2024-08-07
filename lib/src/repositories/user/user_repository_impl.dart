import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dw_barbershop/src/core/exceptions/auth_exceptions.dart';
import 'package:dw_barbershop/src/core/exceptions/repository_exception.dart';

import 'package:dw_barbershop/src/core/fp/either.dart';
import 'package:dw_barbershop/src/core/fp/nil.dart';
import 'package:dw_barbershop/src/core/restClient/rest_client.dart';
import 'package:dw_barbershop/src/model/user_model.dart';

import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RestClient restClient;

  UserRepositoryImpl({required this.restClient});
  @override
  Future<Either<AuthExceptions, String>> login(
      String email, String password) async {
    try {
      final Response(:data) = await restClient.unAuth.post('/auth', data: {
        'email': email,
        'password': password,
      });

      return Success(data['access_token']);
    } on DioException catch (e, s) {
      if (e.response != null) {
        final Response(:statusCode) = e.response!;
        if (statusCode == HttpStatus.forbidden) {
          log('Email ou senha inválidos', error: e, stackTrace: s);
          return Failure(
              AuthUnauthorizedError(message: 'Email ou senha inválidos'));
        }
      }
      log('Erro ao realizar o login', error: e, stackTrace: s);
      return Failure(AuthError(message: 'Email ou senha inválidos'));
    }
  }

  @override
  Future<Either<RepositoryException, UserModel>> me() async {
    try {
      final Response(:data) = await restClient.auth.post('/me');

      return Success(UserModel.fromMap(data));
    } on DioException catch (e, s) {
      log('Erro ao buscar usuario logado', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao buscar usuario logado'));
    } on ArgumentError catch (e, s) {
      log('Json Invalido', error: e, stackTrace: s);
      return Failure(RepositoryException(message: e.message));
    }
  }

  @override
  Future<Either<RepositoryException, Nil>> registerAdmin(
      ({String email, String name, String password}) userData) async {
    try {
      await restClient.unAuth.post('/users', data: {
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'profile': 'ADM',
      });

      return Success(nil);
    } on DioException catch (e, s) {
      log('Erro ao registrar usuario ADM', error: e, stackTrace: s);
      return Failure(
          RepositoryException(message: 'Erro ao registrar usuario ADM'));
    }
  }
}
