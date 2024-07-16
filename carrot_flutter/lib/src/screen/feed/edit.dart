import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screen/feed/index.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:carrot_flutter/src/widget/image_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//수정창

//stf 바뀌는 폼 만드는 단축어
class FeedEdit extends StatefulWidget {
  final FeedModel model;
  const FeedEdit(this.model, {super.key});

  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  int? fileId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  var inputDecoration = const InputDecoration(border: OutlineInputBorder());
  var labelTextStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  final ImagePicker picker = ImagePicker();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final String name = _titleController.text;
      final String price = _priceController.text;
      final String content = _contentController.text;

      //피드생성로직
      bool result = await feedController.feedUpdate(
          widget.model.id!, name, content, price, fileId);
      if (result) {
        Get.until((route) => route.isFirst);
      }
    }
  }

  void initData() async {
    setState(() {
      fileId = widget.model.imageId;
      _titleController.text = widget.model.name ?? '';
      _priceController.text = widget.model.price.toString();
      _contentController.text = widget.model.content ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  void uploadImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    int id = await feedController.upload(image.name, image.path);
    setState(() {
      fileId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('게시글 수정'),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // 이미지 버튼
                Column(
                  children: [
                    ImageButton(
                      imageUrl: fileId == null
                          ? null
                          : "${Global.apiRoot}/api/file/$fileId",
                      onTap: uploadImage,
                    ),
                  ],
                ),
                const SizedBox(height: 20), // 위 여백
                // 제목
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('제목', style: labelTextStyle),
                    SizedBox(height: 10), // 박스랑 내용사이 여백
                    TextFormField(
                      decoration: inputDecoration,
                      controller: _titleController,
                    ),
                  ],
                ),
                const SizedBox(height: 20), // 위 여백
                // 가격
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('태그', style: labelTextStyle),
                    SizedBox(height: 10), // 박스랑 내용사이 여백
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: inputDecoration,
                      controller: _priceController,
                    ),
                  ],
                ),
                const SizedBox(height: 20), // 위 여백
                // 내용
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('내용', style: labelTextStyle),
                    SizedBox(height: 10), // 박스랑 내용사이 여백
                    TextFormField(
                      maxLines: 5,
                      decoration: inputDecoration,
                      controller: _contentController,
                    ),
                  ],
                ),
                const SizedBox(height: 40), // 위 여백
                // 작성 버튼
                ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5B9DFF),
                    ),
                    child: const Text(
                      '작성 완료',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ))
              ],
            )));
  }
}
