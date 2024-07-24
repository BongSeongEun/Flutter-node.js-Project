import 'dart:math';

import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screens/feed/create.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../widget/more_bottom.dart';
import '../../widget/category_button.dart';
import '../../widget/feed_list_item.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});

  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  final feedController = Get.put(FeedController());
  int _currentPage = 1;
  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.feedIndex();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.feedIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const FeedCreate());
        },
        tooltip: '항목 추가',
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text('내 동네'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return MoreBottomModal(
                    cancelTap: () {
                      Navigator.pop(context);
                    },
                    hideTap: () {},
                  );
                },
              );
            },
            icon: Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Column(children: [
        SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                CategoryButton(icon: Icons.menu),
                SizedBox(
                  width: 12,
                ),
                CategoryButton(
                  icon: Icons.search,
                  title: '알바',
                ),
                SizedBox(
                  width: 12,
                ),
                CategoryButton(
                  icon: Icons.home,
                  title: '부동산',
                ),
                SizedBox(
                  width: 12,
                ),
                CategoryButton(
                  icon: Icons.car_crash,
                  title: '중고차',
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            )),
        Expanded(
          child: Obx(
            () => NotificationListener<ScrollNotification>(
              onNotification: _onNotification,
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  itemCount: feedController.feedList.length,
                  itemBuilder: (context, index) {
                    final item = feedController.feedList[index];
                    return FeedListItem(item);
                  },
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
