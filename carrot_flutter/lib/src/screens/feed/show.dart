import 'package:carrot_flutter/src/controller/feed_controller.dart';
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              feedController.currentFeed.value!.title,
                              style: textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${feedController.currentFeed.value!.createdAt}',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              feedController.currentFeed.value!.content,
                              style: textTheme.bodyMedium,
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
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${feedController.currentFeed.value?.price} 원",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    /*
                    Get.to(
                        () => FeedEdit(feedController.currentFeed.value!.id));
                        */
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    /*
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
                                feedController.deleteFeed(
                                    feedController.currentFeed.value!.id);
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
                    */
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
