import 'package:flutter/material.dart';

class MyBoxShadow extends StatelessWidget {
  const MyBoxShadow(
      {super.key,
      required this.child,
      this.width = 200,
      this.top = 5,
      this.bottom = 10});
  final Widget child;
  final double width;
  final double top;
  final double bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(bottom),
          top: Radius.circular(top),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 5),
            blurRadius: 6,
            spreadRadius: 4,
            color: const Color(0xFF000000).withOpacity(.20),
          ),
        ],
      ),
      child: child,
    );
  }
}
