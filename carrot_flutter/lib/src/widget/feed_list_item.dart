import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screen/feed/show.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedListItem extends StatelessWidget {
  final FeedModel model;
  const FeedListItem(this.model, {super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return ListView(
  //     padding: const EdgeInsets.all(10),
  //     children: const [
  //       FeedListItem(),
  //     ],
  //   )
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(model));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //썸네일
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "${Global.apiRoot}/api/file/${model.imageId}",
              width: 200,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('asset/logo.png', width: 200, height: 200);
              },
            ),
          ),
          //내용
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name ?? '제목없음',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 6),
                  Text(model.content ?? '내용없음'),
                  const SizedBox(height: 20), // 위 여백
                  Text(
                    'Tag : ${model.price} ',
                    // '${model.price} 원', 이거 원짜 빼려고 수정한거임
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
          // 메뉴 및 댓글
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            height: 100,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row( // 피드 오른쪽 아이콘 이미지 넣는곳
                //   children: [],
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
