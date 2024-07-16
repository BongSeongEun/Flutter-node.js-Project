import 'package:carrot_flutter/src/screen/auth/intro.dart';
import 'package:carrot_flutter/src/screen/feed/create.dart';
import 'package:carrot_flutter/src/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
      ),
      // home: const Home(),
      home: isLogin ? const Home() : const Intro(),
    );
  }
}
