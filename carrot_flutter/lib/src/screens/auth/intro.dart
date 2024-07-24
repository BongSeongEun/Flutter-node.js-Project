import 'package:carrot_flutter/src/screens/auth/login.dart';
import 'package:carrot_flutter/src/screens/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: 360,
            height: 325,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 198, 40),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
            child: Image.asset(
              'assets/images/intro_image.jpg',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 350),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '여행의 추억, 함께 나누는 감동\n\n당신의 이야기를 들려주세요 ✏️',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 198, 40),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset('assets/images/intro_logo.png'),
                ],
              ),
            ),
          ),
          // 하단 버튼 및 링크
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16.0), // 하단 여백
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const Register());
                    },
                    child: const Text('시작하기'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('이미 계정이 있나요?'),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const Login());
                        },
                        child: const Text('로그인'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}