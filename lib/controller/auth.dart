import 'package:firebase_auth/firebase_auth.dart';
// import 'package:nb_utils/nb_utils.dart';

class ToDoAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
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
        print("Error signing in: $e");
      }
    }
  }
}
