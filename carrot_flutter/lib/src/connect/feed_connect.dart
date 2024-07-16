import 'package:carrot_flutter/src/shared/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final GetStorage _storage = GetStorage();

class FeedConnect extends GetConnect {
  getList(int page) async {
    Response response = await get(
      '/api/feed',
      query: {'page': page.toString()},
      headers: {'token': await getToken},
    );
    print(response); // 오류확인코드
    print(response.statusCode); // 오류확인코드
    print(response.bodyString); // 오류확인코드

    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  get getToken => _storage.read("access_token");
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.apiRoot;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      // Feed는 어차피 token 다 쓰기에 공통으로 넣어둠
      request.headers['token'] = getToken;
      return request;
    });
    super.onInit();
  }

  deleteItem(int id) async {
    Response response = await delete(
      '/api/feed/$id',
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  updateItem(int id, String name, String price, String content,
      {int? imageId}) async {
    Response response = await put(
      '/api/feed/$id',
      {
        'name': name,
        'price': price,
        'content': content,
        if (imageId != null) 'imageId': imageId,
      },
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  showItem(int id) async {
    Response response = await get(
      '/api/feed/$id',
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }

  imageUpload(String name, String path) async {
    final form = FormData({'file': MultipartFile(path, filename: name)});
    Response response = await post('/api/file', form);
    if (response.statusCode == null) throw Exception('통신 에러');
    return response.body;
  }

  storeItem(String name, String price, String content, {int? imageId}) async {
    Response response = await post(
      '/api/feed',
      {
        'name': name,
        'price': price,
        'content': content,
        if (imageId != null) 'imageId': imageId,
      },
      headers: {'token': await getToken},
    );
    if (response.statusCode == null) throw Exception('통신 에러');
    Map<String, dynamic> body = response.body;
    if (body['result'] == 'fail') {
      throw Exception(body['message']);
    }
    return body['data'];
  }
}
