import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:carrot_flutter/src/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Register extends StatefulWidget {
  //동적
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final userController = Get.put(UserController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final RegExp emailRegex =
      RegExp(r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');

  // 회원가입 완료 버튼을 누를때 동작할 함수
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String name = _nameController.text;

      // TODO 회원가입 통신 로직
      bool result = await userController.register(email, name, password);

      // Navigator.of(context).pushReplacement(
      // MaterialPageRoute(builder: (context) => const Home()),
      // );
      if (result) {
        Get.off(() => const Home());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
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
            //이메일 입력부분
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: '이메일',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력하세요.';
                }
                if (!emailRegex.hasMatch(value)) {
                  return '이메일 형식에 맞지 않습니다.';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            TextFormField(
              // 비밀번호 입력부분
              controller: _passwordController,
              obscureText: true, // 비밀번호 별표 설정
              decoration: const InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '닉네임',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 50),
            Container(
              width: 10,
              height: 50,
              child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5B9DFF),
                  ),
                  child: const Text(
                    '회원 가입',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
