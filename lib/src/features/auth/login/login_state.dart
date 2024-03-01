import 'package:flutter/material.dart';
enum LoginStateStatus {
  initial,
  error,
  admLogin,
  employeeLogin,
}

class LoginState {
  final LoginStateStatus state;
  final String? messageError;

  LoginState.initial() : this(state: LoginStateStatus.initial);

    LoginState({
    required this.state,
    this.messageError
  });


  LoginState copyWith({
    LoginStateStatus? state,
    ValueGetter<String?>? messageError    
  }) {
    return LoginState(
          state: state ?? this.state,
      messageError: messageError != null ? messageError() : this.messageError
    );
  }
}
