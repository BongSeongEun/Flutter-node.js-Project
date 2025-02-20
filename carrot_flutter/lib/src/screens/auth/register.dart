import 'package:carrot_flutter/src/screens/auth/register_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final authController = Get.put(AuthController());
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      authController.updateButtonState(_phoneController);
    });
  }

  @override
  void dispose() {
    _phoneController.removeListener(() {
      authController.updateButtonState(_phoneController);
    });
    super.dispose();
  }

  _submit() {
    authController.requestVerificationCode(_phoneController.text);
  }

  _confirm() async {
    bool result = await authController.verifyPhoneNumber(_codeController.text);
    if (result) {
      Get.to(() => const RegisterForm());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Text(
                '휴대폰 번호를 인증해주세요',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const Text('홍당무는 휴대폰 번호로 가입힙니다 \n 휴대폰 번호의 형태를 기입해 주세요'),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: '휴대폰 번호를 입력해주세요.',
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => ElevatedButton(
                  onPressed:
                      authController.isButtonEnabled.value ? _submit : null,
                  child: const Text('인증문자 받기'),
                ),
              ),
              Visibility(
                visible: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20),
                    TextField(
                      controller: _codeController,
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: '인증 번호를 입력해주세요',
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: null, child: Text('인증번호 확인')),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
