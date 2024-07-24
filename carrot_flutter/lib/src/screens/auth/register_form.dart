import 'package:carrot_flutter/src/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final authController = Get.put(AuthController());

  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final _nameController = TextEditingController();

  void _submit() async {
    bool result = await authController.register(
      _passwordController.text,
      _nameController.text,
      null,
    );

    if (result) {
      Get.off(() => const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('회원 가입')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: '비밀번호를 입력해주세요',
                ),
              ),
              TextField(
                controller: _passwordConfirmController,
                obscureText: true,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: '비밀번호를 한 번 더 입력해주세요',
                ),
              ),
              TextField(
                controller: _nameController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: '닉네임을 입력해주세요',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(onPressed: _submit, child: Text('회원가입'))
            ],
          ),
        ));
  }
}
