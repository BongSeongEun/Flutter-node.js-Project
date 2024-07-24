import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/controller/file_controller.dart';
import 'package:carrot_flutter/src/widget/feed_image.dart';
import 'package:carrot_flutter/src/widget/form/label_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedCreate extends StatefulWidget {
  const FeedCreate({super.key});
  @override
  State<FeedCreate> createState() => _FeedCreateState();
}

class _FeedCreateState extends State<FeedCreate> {
  final feedController = Get.put(FeedController());
  final fileController = Get.put(FileController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();

  final _earth = ['국내', '아시아', '미주', '유럽', '대양주'];
  String _selectedEarth = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedEarth = _earth[0];
    });
  }

  _submit() async {
    final result = await feedController.feedCreate(
        _titleController.text,
        _priceController.text,
        _contentController.text,
        fileController.imageId.value,
        _tagController.text,
        _selectedEarth);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 물건 팔기')),
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
                    label: '후기',
                    hintText: '후기를 입력해 주세요!',
                    controller: _contentController,
                  ),
                  LabelTextField(
                    label: '태그',
                    hintText: '해시태그를 이용해 설명해주세요!',
                    controller: _tagController,
                  ),
                  DropdownButton(
                      value: _selectedEarth,
                      items: _earth
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEarth = value!;
                        });
                      })
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
