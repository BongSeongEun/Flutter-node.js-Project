import 'dart:convert';

import 'package:get/get.dart';
import 'provider.dart';

class FeedProvider extends Provider {
  Future<Map<String, dynamic>> index(String? category) async {
    Response response = await get(
      '/api/feed',
      query: {'category': category},
    );

    print("API response: ${response.body}");

    if (response.body is String) {
      return Map<String, dynamic>.from(jsonDecode(response.body));
    } else if (response.body is Map) {
      return Map<String, dynamic>.from(response.body);
    } else {
      throw Exception('Unexpected response format');
    }
  }

  Future<Map> store(
    String title,
    String price,
    String content,
    int? image,
    String tag,
    String category,
  ) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
      'tag': tag,
      'category': category,
    };
    if (image != null) {
      body['imageId'] = image.toString();
    }
    final response = await post('/api/feed', body);
    return response.body;
  }

  Future update(int id, String title, String price, String content, int? image,
      String? tag, String category) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
      'tag': tag,
      'category': category,
    };
    if (image != null) {
      body['imageId'] = image.toString();
    }
    final response = await put('/api/feed/$id', body);
    print(response.bodyString);
    return response.body;
  }

  Future<Map> show(int id) async {
    final response = await get('/api/feed/$id');
    return response.body;
  }

  Future<Map> destroy(int id) async {
    final response = await delete('/api/feed/$id');
    return response.body;
  }
}
