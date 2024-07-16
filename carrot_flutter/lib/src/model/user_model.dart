class UserModel {
  int? id;
  String? email;
  String? name;

  // /** 이름이 있는 생성자
  //  *
  //  * {
  //  *    "id" : 1,
  //  *    "name" : "홍길동",
  //  *    "email" : "hello@naver.com"
  //  * }
  //  * 이런식의 jsonData (map) 을 클래스에 멤버변수들에게 초기화
  //  */
  UserModel.fromJson(Map m) {
    id = m['id'];
    email = m['email'];
    name = m['email'];
  }
}
