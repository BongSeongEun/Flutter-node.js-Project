import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:carrot_flutter/src/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userController = Get.put(UserController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() async {
    // 현재 폼에서 별다른 오류가 없을때
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text; // 이메일값
      final String password = _passwordController.text; // 비밀번호값

      bool result = await userController.login(email, password);

      // TODO : 회원가입 성공시 다음 화면 (메인) 으로 이동처리
      if (result) {
        Get.offAll(() => const Home());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 20),
            Image.asset('asset/logo-copy.png', width: 70, height: 70),
            SizedBox(height: 30),

            const Text(
              '아래 회원정보를 입력해주세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            // 이메일 입력부분
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력하세요';
                }
                if (value.length < 5) {
                  return '잘못된 입력입니다';
                }
                return null;
              },
            ),
            SizedBox(height: 40),
            // 비밀번호 입력부분
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력하세요';
                }
                return null;
              },
            ),
            SizedBox(
              height: 50,
            ),
            // 회원가입 완료 버튼
            Container(
              width: 10,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5B9DFF),
                ),
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )

            // ElevatedButton(

            //     onPressed: _submit,
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color(0xff5B9DFF),
            //     ),
            //     child: Text('회원 가입')),
          ],
        ),
      ),
    );
  }
}
