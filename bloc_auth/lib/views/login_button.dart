// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_auth/stirngs.dart';
import 'package:flutter/material.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTap;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onLoginTap(
        emailController.text,
        passwordController.text,
      ),
      child: const Text(login),
    );
  }
}
