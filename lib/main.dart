// import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:json_theme/json_theme.dart';
import 'package:provider/provider.dart';

import 'controller/provider.dart';
import 'firebase_options.dart';
import 'view/screen/auth.dart';
import 'view/screen/home.dart';

// import 'view/utils/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData? theme;
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   _addedFn();
    // });
    super.initState();
  }

  // _addedFn() async {
  //   final themeStr = await rootBundle.loadString(MyTodoImages.lightThemeJson);
  //   final themeJson = jsonDecode(themeStr);
  //   theme = ThemeDecoder.decodeThemeData(themeJson)!;
  // }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: theme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            } else if (snapshot.hasData) {
              return const MyHome();
            } else {
              return MyAuth();
            }
          },
        ),
      ),
    );
  }
}
