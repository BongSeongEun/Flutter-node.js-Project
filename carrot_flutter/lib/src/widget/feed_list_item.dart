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
              Container(
                margin: EdgeInsets.only(left: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    item.imageUrl,
                    width: _imageSize,
                    height: _imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15),
                    Text(
                      item.content.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      TimeUtil.parse(item.createdAt),
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(width: 15),
                    Text(
                      item.tag.toString(),
                      style: TextStyle(color: Colors.grey, fontSize: 10),
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
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 120, bottom: 10),
            child: Divider(
              color: Color.fromARGB(255, 197, 197, 197),
              thickness: 1.0,
              indent: 15.0,
              endIndent: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
