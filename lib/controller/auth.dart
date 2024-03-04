import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
// import 'package:nb_utils/nb_utils.dart';

class ToDoAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final privider = Provider.of<MainProvider>(context, listen: false);
    privider.doLoading(true);

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // toast(
      //     "You have no account in our system, don't worry we are create new one for you");
    } catch (e) {
      print("Error signUp in: $e");
      try {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } catch (e) {
        toast(e.toString());
        print("Error signing in: $e");
      }
    }
    privider.doLoading(false);
  }
}
