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
  String _selectedCategory = '국내';

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.feedIndex(_selectedCategory);
  }

  @override
  void initState() {
    super.initState();
    _onRefresh(); // 초기 로드
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.feedIndex(_selectedCategory);
      return true;
    }
    return false;
  }

  void _updateCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
    _onRefresh(); // 새로운 카테고리로 데이터 갱신
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
        backgroundColor: const Color.fromARGB(255, 255, 198, 40),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logoo.png',
          width: 140,
          height: 140,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 198, 40),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20, top: 15),
            height: 40, // Adjust the height as needed
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                CategoryButton(
                  title: '국내 여행',
                  onPressed: () => _updateCategory('국내'),
                  isSelected: _selectedCategory == '국내',
                ),
                const SizedBox(width: 8),
                CategoryButton(
                  title: '아시아 여행',
                  onPressed: () => _updateCategory('아시아'),
                  isSelected: _selectedCategory == '아시아',
                ),
                const SizedBox(width: 8),
                CategoryButton(
                  title: '미주 여행',
                  onPressed: () => _updateCategory('미주'),
                  isSelected: _selectedCategory == '미주',
                ),
                const SizedBox(width: 8),
                CategoryButton(
                  title: '유럽 여행',
                  onPressed: () => _updateCategory('유럽'),
                  isSelected: _selectedCategory == '유럽',
                ),
                const SizedBox(width: 8),
                CategoryButton(
                  title: '대양주 여행',
                  onPressed: () => _updateCategory('대양주'),
                  isSelected: _selectedCategory == '대양주',
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
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
        ],
      ),
    );
  }
}
