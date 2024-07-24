import 'package:carrot_flutter/src/controller/feed_controller.dart';
import 'package:carrot_flutter/src/controller/file_controller.dart';
import 'package:carrot_flutter/src/model/feed_model.dart';
import 'package:carrot_flutter/src/screens/feed/show.dart';
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
  final TextEditingController _tagController = TextEditingController();

  final _earth = ['국내', '아시아', '미주', '유럽', '대양주'];
  String _selectedEarth = '';

  _submit() async {
    final result = await feedController.feedUpdate(
        widget.model.id,
        _titleController.text,
        _priceController.text,
        _contentController.text,
        fileController.imageId.value,
        _tagController.text,
        _selectedEarth);
    if (result) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FeedShow(widget.model.id)),
      );
    }
    print(result);
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.model.title;
    _priceController.text = widget.model.price.toString();
    _contentController.text = widget.model.content;
    fileController.imageId.value = widget.model.imageId;
    _tagController.text = widget.model.tag;
    // _selectedEarth = widget.model.category;
    setState(() {
      _selectedEarth = widget.model.category;
    });
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
                    hintText: '제목을 입력해 주세요!',
                    controller: _titleController,
                  ),
                  LabelTextField(
                    label: '후기',
                    hintText: '후기를 입력해 주세요!',
                    controller: _contentController,
                    maxLines: 5,
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
                child: const Text('수정 완료'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
