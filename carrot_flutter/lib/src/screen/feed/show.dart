import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screen/feed/edit.dart';
import 'package:carrot_flutter/src/screen/feed/index.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedShow extends StatefulWidget {
  final FeedModel feed;
  const FeedShow(this.feed, {super.key});

  @override
  State<FeedShow> createState() => _FeedShowState();
}

class _FeedShowState extends State<FeedShow> {
  bool isMe = false;

  _delete() {
    showDialog(
      context: context,
      builder: (context) {
        // dialog을 활용
        return AlertDialog(
          title: const Text("게시글 삭제"),
          content: const Text("정말 삭제 하시겠습니까"),
          actions: [
            TextButton(
              child: const Text("취소"),
              onPressed: () {
                Get.back(); // 취소할때 팝업을 지우는 함수
              },
            ),
            TextButton(
              child: const Text("확인"),
              onPressed: () async {
                // 확인은 이미 민들어놨음
                bool result = await feedController.feedDelete(widget.feed.id!);
                if (result) {
                  //결과가 잘 지워졌으면 경고창도 지워주고 상세페이지도 나가는것
                  Get.until((route) => route.isFirst);
                }
              },
            ),
          ],
        );
      },
    );
  }

  _edit() {
    Get.to(() => FeedEdit(widget.feed));
  }

  @override
  void initState() {
    super.initState();
    _checkMine();
  }

  _checkMine() async {
    bool result = await feedController.feedShow(widget.feed.id!);
    setState(() {
      isMe = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('후기'),
        actions: isMe
            ? [
                IconButton(
                  onPressed: _delete,
                  icon: const Icon(Icons.delete_outline),
                ),
                IconButton(
                  onPressed: _edit,
                  icon: const Icon(Icons.edit_outlined),
                ),
              ]
            : null,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView(
              children: [
                Image.network(
                  "${Global.apiRoot}/api/file/${widget.feed.imageId}",
                  width: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'asset/logo.png',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    );
                  },
                ),
                Container(
                  color: Color(0xff5B9DFF),
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.feed.name ?? '제목 없음',
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    widget.feed.content ?? '내용없음',
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   decoration: const BoxDecoration(
          //     border: Border(
          //       top: BorderSide(width: 1, color: Color(0xFFFFFFFF)),
          //     ),
          //   ),
          //   padding: const EdgeInsets.all(15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "${widget.feed.price.toString()} 원",
          //         style: const TextStyle(
          //             fontSize: 20, fontWeight: FontWeight.bold),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      )),
    );
  }
}
