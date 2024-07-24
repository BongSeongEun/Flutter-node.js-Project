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
        body: Column(
      children: [
        Expanded(
            child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                        'https://cdn.pixabay.com/photo/2023/07/10/03/42/carrot-illustration-8117291_1280.png',
                        width: 300,
                        height: 300),
                    const SizedBox(height: 20),
                    const Text(
                      '당신 근처의 홍당무',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '동네라서 가능한 모든 것\n지금 내 동네를 선택하고 시작해보세요!',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              Get.to(() => const Register());
                            },
                            child: const Text('시작하기')),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('이미 계정이 있나요?'),
                            TextButton(
                                onPressed: () {
                                  Get.to(() => const Login());
                                },
                                child: const Text('로그인'))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ))
      ],
    ));
  }
}
