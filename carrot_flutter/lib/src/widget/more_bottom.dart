import 'package:flutter/material.dart';

class MoreBottomModal extends StatelessWidget {
  final VoidCallback cancelTap;
  final VoidCallback hideTap;
  final VoidCallback? delete;

  const MoreBottomModal({
    required this.cancelTap,
    required this.hideTap,
    this.delete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.visibility_off_outlined),
                    title: Text('이 글 숨기기'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('글 숨기기'),
                              content: const Text('이 글을 숨기시겠습니까?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('취소')),
                                TextButton(
                                    onPressed: () {
                                      hideTap();
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('숨기기')),
                              ],
                            );
                          });
                    },
                  ),
                  ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('게시글노출기준')),
                  ListTile(
                    leading: Icon(
                      Icons.warning_amber_outlined,
                      color: Colors.red,
                    ),
                    title: Text('신고하기'),
                    textColor: Colors.red,
                  ),
                  Visibility(
                    visible: delete != null,
                    child: ListTile(
                      leading: const Icon(Icons.delete_outline),
                      title: const Text('삭제하기'),
                      onTap: delete,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: const Text('닫기', textAlign: TextAlign.center),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ));
  }
}
