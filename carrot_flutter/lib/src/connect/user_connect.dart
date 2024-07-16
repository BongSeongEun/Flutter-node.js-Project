import 'package:carrot_flutter/src/shared/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// 단순한 통신은 connect 가, 저장하고 처리는 controller가 한다
final GetStorage _storage = GetStorage();

// 회원 관련된 통신을 담당하는 클래스
class UserConnect extends GetConnect {
  // 회원가입 통신
  // 회원가입을 눌렀을때 실제로 통신
  Future sendRegister(String email, String name, String password) async {
    Response response = await post('/api/user/register', {
      'email': email,
      'name': name,
      'password': password,
    });
    print(response);
    print(response.statusCode);
    print(response.bodyString);
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['access_token'];
  }

  // 로그인 통신
  Future sendLogin(String email, String password) async {
    Response response = await post('/api/user/login', {
      'email': email,
      'password': password,
    });

    print(response.statusCode); //오류확인코드
    print(response.bodyString); //오류확인코드
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['access_token'];
  }

  // 나의 정보 통신
  // 내 정보정도는 보여야해서 만든거 (나의 이름 이메일 등의 정보)
  Future getMyInfo() async {
    Response response = await get(
      '/api/user/mypage',
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;

    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body;
  }

  get getToken async {
    return _storage.read("accessToken");
  }

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      return request;
    });
    super.onInit();
  }
}

//   @override 변경 전
//   // 다른통신을 하기 전에 가장 먼저 실행
//   void onInit() {
//     // text 서버에 통신해야되니깐 사용
//     allowAutoSignedCert = true;
//     // 내 서버의 주소를 입력 (서버의 도메인을 적으면댐)
//     httpClient.baseUrl = 'http://localhost:3000';
//     // 헤더값 문서를 보는방식과 클라이언트들이 js통신하는것 두가지 존재
//     // 어플리케이션류이고 제이슨방식으로 통신할겁니다를 미리 선언
//     // 보안에대한 인증서명을 자동적으로 해주면 사용하겠습니다
//     httpClient.addRequestModifier<void>((request) {
//       request.headers['Accept'] = 'application/json';
//       return request;
//     });
//     super.onInit();
//   }
// }
