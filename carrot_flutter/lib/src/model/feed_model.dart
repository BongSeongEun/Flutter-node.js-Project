import 'package:carrot_flutter/src/model/user_model.dart';
import 'package:carrot_flutter/src/shared/global.dart';

class FeedModel {
  late int id;
  late String title;
  late String content;
  late int? price;
  int? imageId;
  DateTime? createdAt;
  bool isMe = false;
  UserModel? writer;
  late String tag;
  late String category;

  get imageUrl => (imageId != null)
      ? "${Global.baseUrl}/file/$imageId"
      : "https://cdn-icons-png.flaticon.com/512/5078/5078670.png";

  FeedModel(
      {required this.id,
      required this.title,
      required this.content,
      required this.price,
      required this.createdAt,
      this.imageId,
      required this.isMe,
      required this.writer,
      required this.tag,
      required this.category});
  FeedModel.parse(Map m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    price = m['price'];
    imageId = m['image_id'];
    createdAt = DateTime.parse(m['created_at']);
    isMe = m['is_me'] ?? false;
    writer = (m['writer'] != null) ? UserModel.parse(m['writer']) : null;
    tag = m['tag'];
    category = m['category'];
  }
  FeedModel copyWith({
    int? id,
    String? title,
    String? content,
    int? price,
    int? imageId,
    DateTime? createdAt,
    bool? isMe,
    UserModel? writer,
    String? tag,
    String? category,
  }) {
    return FeedModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      price: price ?? this.price,
      imageId: imageId ?? this.imageId,
      createdAt: createdAt ?? this.createdAt,
      isMe: isMe ?? this.isMe,
      writer: writer ?? this.writer,
      tag: tag ?? this.tag,
      category: category ?? this.category,
    );
  }
}
