import 'dart:math';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/providers/feed_provider.dart';
import 'package:get/get.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  RxList<FeedModel> feedList = <FeedModel>[].obs;
  final Rx<FeedModel?> currentFeed = Rx<FeedModel?>(null); // 추가
  Future<void> feedShow(int id) async {
    // 추가
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

  Future<void> feedIndex({int page = 1}) async {
    Map json = await feedProvider.index(page);
    List<FeedModel> tmp =
        json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
    print(json);
  }

  Future<bool> feedCreate(String title, String price, String content,
      int? image, String tag, String category) async {
    Map body =
        await feedProvider.store(title, price, content, image, tag, category);
    if (body['result'] == 'ok') {
      await feedIndex();
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }
}
