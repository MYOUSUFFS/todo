import 'package:flutter/material.dart';

class MyInputDecoration {
  InputDecoration inputDecoration(String hintText) => InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}

extension MyInput on String {
  String trimAndRemove() => this.trim().replaceAll(" ", "");
}
