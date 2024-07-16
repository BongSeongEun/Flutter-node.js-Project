import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../connect/feed_connect.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mysql_client/mysql_client.dart';

final feedConnect = Get.put(FeedConnect());

class FeedControlelr extends GetxController {
  List<FeedModel> list = [];

  feedIndex({int page = 1}) async {
    List jsonData = await feedConnect.getList(page);
    if (page == 1) {
      list.clear();
    }
    List<FeedModel> tmp = jsonData.map((m) => FeedModel.parse(m)).toList();
    list.addAll(tmp);
    update();
  }

  Future<bool> feedDelete(int id) async {
    try {
      String result = await feedConnect.deleteItem(id);
      list.removeWhere((feed) => feed.id == int.parse(result));
      update();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  Future<bool> feedUpdate(
      int id, String name, String content, String price, int? imageId) async {
    try {
      Map data = await feedConnect.updateItem(id, name, price, content,
          imageId: imageId);
      int index = list.indexWhere((item) => item.id == id);
      if (index != -1) {
        list[index].updateWith({
          'name': data['name'],
          'content': data['content'],
          'price': data['price'],
          'image_id': data['image_id'],
        });
        //print(title)
        update(); // UI 업데이트
      }
      await feedIndex();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  Future<int> upload(String title, String path) async {
    Map data = await feedConnect.imageUpload(title, path);
    return data['id'];
  }

  Future<bool> feedShow(int id) async {
    try {
      Map m = await feedConnect.showItem(id);
      return m['is_me'];
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }

  // 피드 생성 붑
  Future<bool> feedCreate(
      String name, String content, String price, int? imageId) async {
    try {
      await feedConnect.storeItem(name, price, content, imageId: imageId);
      await feedIndex();
      return true;
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Text("$e"),
      ));
      return false;
    }
  }
}
