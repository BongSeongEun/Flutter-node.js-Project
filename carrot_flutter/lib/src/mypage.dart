import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final storage = GetStorage();
          await storage.erase();
          Get.offAllNamed('/intro');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 198, 40),
        ),
        child: const Text('로그아웃'),
      ),
    );
  }
}
