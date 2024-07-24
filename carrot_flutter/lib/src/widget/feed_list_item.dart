import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screens/feed/show.dart';
import 'package:carrot_flutter/src/timeUtil.dart';
import 'package:flutter/material.dart';
import '../screens/feed/feed_edit.dart';
import 'package:get/get.dart';

const double _imageSize = 110;

class FeedListItem extends StatelessWidget {
  final FeedModel item;

  const FeedListItem(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final feedController = Get.put(FeedController());

    return InkWell(
      onTap: () {
        Get.to(() => FeedShow(item.id));
      },
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    item.imageUrl,
                    width: _imageSize,
                    height: _imageSize,
                    fit: BoxFit.cover,
                  )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text(
                          '동네이름',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          TimeUtil.parse(item.createdAt),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      item.price.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 16,
                  ))
            ],
          ),
          Positioned(
            right: 10,
            bottom: 0,
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 2),
                Text(
                  '1',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.favorite_border,
                  color: Colors.grey,
                  size: 16,
                ),
                SizedBox(width: 2),
                Text(
                  '1',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
