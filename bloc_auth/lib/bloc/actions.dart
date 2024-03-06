import 'package:flutter/material.dart' show immutable;

@immutable
abstract interface class AppAction {
  const AppAction();
}

@immutable
class LoginAction implements AppAction {
  final String email;
  final String password;
  
  const LoginAction({
    required this.email,
    required this.password,
  });
}
@immutable
class LoadNotesAction implements AppAction {
  final String email;
  final String password;

  const LoadNotesAction({
    required this.email,
    required this.password,
  });
}
