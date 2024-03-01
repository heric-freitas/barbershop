sealed class AuthExceptions implements Exception {
  AuthExceptions({required this.message});
  final String message;

  T when<T>({
    required T Function(String message) authError,
    required T Function(String message) authUnauthorizedError,
  }) =>
      switch (this) {
        AuthError(:final message) => authError(message),
        AuthUnauthorizedError(:final message) => authUnauthorizedError(message),
      };
}

class AuthError extends AuthExceptions {
  AuthError({required super.message});
}

class AuthUnauthorizedError extends AuthExceptions {
  AuthUnauthorizedError({required super.message});
}
