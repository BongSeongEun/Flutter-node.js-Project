import 'package:carrot_flutter/src/model/user_model.dart';
import 'package:carrot_flutter/src/shared/global.dart';

class FeedModel {
  late int id;
  late String title;
  late String content;
  late int price;
  int? imageId;
  DateTime? createdAt;
  bool isMe = false;
  UserModel? writer;

  get imageUrl => (imageId != null)
      ? "${Global.baseUrl}/file/$imageId"
      : "https://example.com/image.jpg";

  FeedModel({
    required this.id,
    required this.title,
    required this.content,
    required this.price,
    required this.createdAt,
    this.imageId,
    required this.isMe,
    required this.writer,
  });
  FeedModel.parse(Map m) {
    id = m['id'];
    title = m['title'];
    content = m['content'];
    price = m['price'];
    imageId = m['image_id'];
    createdAt = DateTime.parse(m['created_at']);
    isMe = m['is_me'] ?? false;
    writer = (m['writer'] != null) ? UserModel.parse(m['writer']) : null;
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
    );
  }
}
