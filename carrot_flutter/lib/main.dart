import 'package:carrot_flutter/src/timeUtil.dart';
import 'package:flutter/material.dart';
import 'src/app.dart';
import 'src/shared/global.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  TimeUtil.init();

  final box = GetStorage();
  String? token = box.read('access_token');
  bool isLogin = (token != null) ? true : false;
  runApp(MyApp(isLogin));
}
