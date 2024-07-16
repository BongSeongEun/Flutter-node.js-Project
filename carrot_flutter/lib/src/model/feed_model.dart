class FeedModel {
  int? id;
  String? name;
  String? price;
  String? content;
  DateTime? createdAt;
  int? userId;
  int? imageId;
  FeedModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
    price = m['price'];
    content = m['content'];
    createdAt = DateTime.parse(m['created_at']);
    userId = m['user_id'];
    imageId = m['image_id'];
  }

  void updateWith(Map<String, dynamic> newValues) {
    name = newValues['name'] ?? name;
    price = newValues['price'] ?? price;
    content = newValues['content'] ?? content;
    imageId =
        newValues['image_id'] != null ? int.parse(newValues['image_id']) : null;
  }
}
