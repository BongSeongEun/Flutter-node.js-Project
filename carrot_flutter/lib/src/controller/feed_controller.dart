import 'dart:math';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/providers/feed_provider.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  RxList<FeedModel> feedList = <FeedModel>[].obs;
  final Rx<FeedModel?> currentFeed = Rx<FeedModel?>(null);

  Future<void> feedShow(int id) async {
    Map body = await feedProvider.show(id);
    if (body['result'] == 'ok') {
      currentFeed.value = FeedModel.parse(body['data']);
    } else {
      Get.snackbar('피드에러', body['message'],
          snackPosition: SnackPosition.BOTTOM);
      currentFeed.value = null;
    }
  }

  Future<bool> feedDelete(int id) async {
    // 추가
    Map body = await feedProvider.destroy(id);
    if (body['result'] == 'ok') {
      feedList.removeWhere((feed) => feed.id == id);
      return true;
    }
    Get.snackbar('삭제에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  feedUpdate(int id, String title, String priceString, String content,
      int? image, String tag, String category) async {
    int price = 0;
    Map body = await feedProvider.update(
        id, title, priceString, content, image, tag, category);
    if (body['result'] == 'ok') {
      int index = feedList.indexWhere((feed) => feed.id == id);
      if (index != -1) {
        FeedModel updatedFeed = feedList[index].copyWith(
            title: title,
            price: price,
            content: content,
            imageId: image,
            tag: tag,
            category: category);
        feedList[index] = updatedFeed;
        print(updatedFeed);
      }
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> feedIndex(String? category) async {
    try {
      final Map<String, dynamic> json = await feedProvider.index(category);

      print("Full JSON response: $json"); // 전체 JSON 응답 출력

      if (json['result'] == 'error') {
        throw Exception(json['message'] ?? 'Unknown error occurred');
      }

      if (json['data'] is List) {
        List<FeedModel> tmp = (json['data'] as List)
            .map((m) => FeedModel.parse(m as Map<String, dynamic>))
            .toList();
        feedList.assignAll(tmp);
      } else if (json['data'] is Map<String, dynamic>) {
        // 단일 객체인 경우 처리
        FeedModel singleFeed =
            FeedModel.parse(json['data'] as Map<String, dynamic>);
        feedList.assignAll([singleFeed]);
      } else {
        print(
            "Unexpected 'data' format: ${json['data']}"); // 'data' 필드의 실제 형식 출력
        throw Exception('Unexpected data format');
      }
    } catch (e) {
      print('Error in feedIndex: $e');
      // 에러 처리 - 스낵바 표시
      Get.snackbar('피드 로딩 에러', '피드를 불러오는 중 오류가 발생했습니다: $e',
          snackPosition: SnackPosition.BOTTOM);
      // 필요하다면 여기서 feedList를 초기화하거나 다른 에러 처리 로직을 추가할 수 있습니다.
      feedList.clear(); // 에러 발생 시 feedList 초기화
    }
  }

  Future<bool> feedCreate(String title, String price, String content,
      int? image, String tag, String category) async {
    Map body =
        await feedProvider.store(title, price, content, image, tag, category);
    if (body['result'] == 'ok') {
      await feedIndex(category);
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
