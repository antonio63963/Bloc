import 'package:bloc_auth/models.dart';
import 'package:flutter/material.dart' show immutable;

abstract interface class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  // singletone pattern
  const LoginApi._sharedInstance();
  static const LoginApi shared = LoginApi._sharedInstance();
  factory LoginApi() => shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 3),
        () => email == 'foo' && password == '123123',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
      );
}
