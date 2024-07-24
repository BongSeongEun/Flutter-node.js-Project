import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../shared/global.dart';

class Provider extends GetConnect {
  final box = GetStorage();
  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = 'http://10.0.2.2:3000';
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      if (request.url.toString().contains('/api/')) {
        request.headers['Authorization'] = "Bearer ${box.read('access_token')}";
      }
      return request;
    });
    super.onInit();
  }
}
