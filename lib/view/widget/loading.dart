import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/view/utils/const.dart';

class MyLoading extends StatelessWidget {
  const MyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.9),
              Colors.white.withOpacity(0.7),
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
          // color: Colors.white.withOpacity(.8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              MyTodoImages.loading,
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
