import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/auth.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/view/utils/input_decoration.dart';
import 'package:todo/view/widget/loading.dart';

import '../utils/const.dart';
import '../widget/text_field.dart';

class MyAuth extends StatelessWidget {
  MyAuth({super.key});
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final privider = Provider.of<MainProvider>(context);
    return PopScope(
      onPopInvoked: (_) {
        privider.doLoading(false);
      },
      child: Stack(
        children: [
          Scaffold(
            body: Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(MyTodoImages.logo, height: 150),
                    // SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "My Todo",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orange.withOpacity(.5),
                          decorationThickness: 3,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: email,
                      decoration: MyInputDecoration().inputDecoration("Email"),
                    ),
                    const SizedBox(height: 10),
                    PasswordTextField(password: password),
                    const SizedBox(height: 10),
                    AppButton(
                      text: "Login",
                      height: 50,
                      width: double.infinity,
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () async {
                        if (email.text.isEmpty || password.text.isEmpty) {
                          toast('All fields are required!');
                        } else {
                          await ToDoAuth().signInWithEmailAndPassword(
                            context,
                            email: email.text.toLowerCase().trimAndRemove(),
                            password: password.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (privider.isLoading) MyLoading()
        ],
      ),
    );
  }
}
