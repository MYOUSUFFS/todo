import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/auth.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/view/utils/input_decoration.dart';

class MyAuth extends StatelessWidget {
  MyAuth({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final privider = Provider.of<MainProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: email,
                  decoration: MyInputDecoration().inputDecoration("Email"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: password,
                  decoration: MyInputDecoration().inputDecoration("password"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await ToDoAuth().signInWithEmailAndPassword(
                      context,
                      email: email.text,
                      password: password.text,
                    );
                  },
                  child: const Text("Start"),
                )
              ],
            ),
          ),
          if (privider.isLoading)
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
