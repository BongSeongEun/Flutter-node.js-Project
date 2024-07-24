import 'package:carrot_flutter/src/model/user_model.dart';
import 'package:get/get.dart';
import '../providers/user_provider.dart';

class UserController extends GetxController {
  final provider = Get.put(UserProvider());
  final Rx<UserModel?> my = Rx<UserModel?>(null);
  Future<void> myInfo() async {
    Map body = await provider.show();
    if (body['result'] == 'ok') {
      my.value = UserModel.parse(body['data']);
      return;
    }
    Get.snackbar('회원에러', body['message'], snackPosition: SnackPosition.BOTTOM);
  }
}
