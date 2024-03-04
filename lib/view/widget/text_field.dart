import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key, required this.password});
  final TextEditingController password;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.password,
        obscureText: isObscured,
        decoration: InputDecoration(
          hintText: "password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              isObscured = !isObscured;
              setState(() {});
            },
            icon: Icon(isObscured ? Icons.visibility_off : Icons.visibility),
          ),
        ));
  }
}
