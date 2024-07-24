import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screens/feed/feed_edit.dart';
import 'package:carrot_flutter/src/widget/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedShow extends StatefulWidget {
  final int feedId;
  const FeedShow(this.feedId, {super.key});
  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  final FeedController feedController = Get.find<FeedController>();
  @override
  void initState() {
    super.initState();
    feedController.feedShow(widget.feedId);
  }

  _chat() {}
  @override
  Widget build(BuildContextcontext) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Obx(() {
            final feed = feedController.currentFeed.value;
            return SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height / 3,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: feed != null
                    ? Image.network(feed.imageUrl, fit: BoxFit.cover)
                    : null,
              ),
            );
          }),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Obx(() {
              if (feedController.currentFeed.value != null) {
                final textTheme = Theme.of(context).textTheme;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserListItem(feedController.currentFeed.value!.writer!),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feedController.currentFeed.value!.title,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              feedController.currentFeed.value!.content,
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 40),
                            Text(
                              '${feedController.currentFeed.value!.createdAt}',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade200))),
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${feedController.currentFeed.value?.tag}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.grey),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    Get.to(() => FeedEdit(
                        feedController.currentFeed.value as FeedModel));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('삭제 확인'),
                          content: Text('정말로 이 피드를 삭제하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                // 삭제 처리 로직
                                feedController.feedDelete(
                                    feedController.currentFeed.value!.id);
                                Get.back();
                                Navigator.pop(context);
                              },
                              child: Text('삭제'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('취소'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
