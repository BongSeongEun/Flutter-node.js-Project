import 'package:carrot_flutter/src/screens/feed/show.dart';
import 'package:flutter/material.dart';
import 'screens/auth/intro.dart';
import 'screens/auth/register.dart';
import 'home.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final bool isLogin;
  const MyApp(this.isLogin, {super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 198, 40),
              textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 10),
              fixedSize: Size(
                  MediaQuery.of(context).size.width * 0.8, 50), // 버튼의 고정 크기 설정
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 255, 198, 40),
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          )),
          inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              floatingLabelStyle: TextStyle(fontSize: 10),
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )),
          textTheme: const TextTheme(
              labelLarge: TextStyle(
            fontSize: 16,
            fontFamily: 'Noto Sans',
            fontWeight: FontWeight.bold,
          ))),
      routes: {
        // '/': (context) => Home(),
        '/': (context) => Home(),
        '/intro': (context) => Intro(),
        '/register': (context) => Register(),
      },
      initialRoute: isLogin ? '/' : '/intro',
    );
  }
}
