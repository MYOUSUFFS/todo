import 'package:flutter/material.dart';

class MyInputDecoration {
  inputDecoration(String hintText) => InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
