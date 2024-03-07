import 'package:bloc_auth/stirngs.dart' show enterYourEmailHere;
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
   PasswordTextField({super.key});
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      obscuringCharacter: '*',
      decoration: const InputDecoration(
        hintText: enterYourEmailHere
      ),
    );
  }
}
