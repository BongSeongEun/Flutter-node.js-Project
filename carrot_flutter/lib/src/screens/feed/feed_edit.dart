import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/controller/file_controller.dart';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/widget/feed_image.dart';
import 'package:carrot_flutter/src/widget/form/label_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel model; // 추가
  const FeedEdit(this.model, {super.key});
  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  final feedController = Get.put(FeedController());
  final fileController = Get.put(FileController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  _submit() async {
    final result = await feedController.feedUpdate(
      widget.model.id, // 변경
      _titleController.text,
      _priceController.text,
      _contentController.text,
      fileController.imageId.value,
    );
    if (result) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.model.title;
    _priceController.text = widget.model.price.toString();
    _contentController.text = widget.model.content;
    fileController.imageId.value = widget.model.imageId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('물건 정보 수정')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: fileController.upload,
                          child: Obx(
                            () => FeedImage(fileController.imageUrl),
                          )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LabelTextField(
                    label: '제목',
                    hintText: '제목',
                    controller: _titleController,
                  ),
                  LabelTextField(
                      label: '가격',
                      hintText: '가격을 입력해주세요.',
                      controller: _priceController,
                      keyboardType: TextInputType.phone),
                  LabelTextField(
                    label: '자세한 설명',
                    hintText: '자세한 설명을 입력하세요',
                    controller: _contentController,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('작성 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
