import 'provider.dart';

class UserProvider extends Provider {
  Future<Map> show() async {
    final response = await get('/api/user/my');
    return response.body;
  }
}
