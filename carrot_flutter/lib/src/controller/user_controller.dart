import 'package:carrot_flutter/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../connect/user_connect.dart';

final GetStorage _storage = GetStorage();

// /**
//  * 회원 동작과 관련된 모든 상태들을 공통으로 관리하는 클래스
//  */
// // 통신하는건 connect 저장하는건 controller
class UserController extends GetxController {
//   /**
//    * 웹이나 앱개발을 할때는 이 방법을 많이사용
//    * class를 매번 생성자를 통해 만들면 데이터량이 늘어나기때문에
//    * 하나의 객체만 있으면 되지않을까?
//    * -> 내가 생성자를 통해 직접만드는게아니고 도구들이 스스로 알아서
//    * 집어넣어주는것 (계속생성x 메모리에 있으면 가지고오고 없으면 만드는것)
//    * --> 여기에 객체가 생성된는구나 정도
//    */
  final userConnection = Get.put(UserConnect());

  // 공통으로 관리할 멤버변수
  UserModel? user;

  // 로그인이 되었는지 판단
  Future<bool> isLogin() async {
    await _storage.remove('access_token'); //토큰 지우기
    return _storage.hasData('access_token');
  }

  // 회원가입을 시도하는 함수,  아마 connect를 호출할것이다.
  // 토큰을 확인
  Future<bool> register(String email, String name, String password) async {
    try {
      String token = await userConnection.sendRegister(email, name, password);
      _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // 로그인을 시도하는 함수, 아마 connect를 호출할것이다.
  Future<bool> login(String email, String password) async {
    try {
      String token = await userConnection.sendLogin(email, password);
      _storage.write('access_token', token);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // 나의 정보를 가져오는 함수, 아마 connect를 호출할것이다.
  Future mypage() async {
    Map map = await userConnection.getMyInfo();
    UserModel parseUser = UserModel.fromJson(map);
    user = parseUser;
  }
}
