import 'package:carrot_flutter/src/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:carrot_flutter/src/screen/auth/register.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asset/logo-copy.png', width: 250, height: 200),
                  //Container(color: Colors.grey, width: 200, height: 200),
                  //const SizedBox(height: 10),
                  const Text(
                    '막막했던 여행 준비\n간단하게 해보세요 :)   ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    '여행 후기는 트레블쉐어와 함께',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              )),
              SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Register(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5B9DFF),
                  ),
                  child: const Text(
                    '시작하기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('이미 계정이 있나요? '),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          //builder: (context) => const Home(), //임시로
                          builder: (context) => const Login(),
                        ));
                      },
                      child: const Text('로그인')),
                  const SizedBox(height: 100),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
