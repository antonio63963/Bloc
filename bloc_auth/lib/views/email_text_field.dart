import 'package:bloc_auth/stirngs.dart' show enterYourEmailHere;
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
   EmailTextField({super.key});
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: enterYourEmailHere
      ),
    );
  }
}
