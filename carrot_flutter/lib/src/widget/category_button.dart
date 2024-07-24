import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? title;

  const CategoryButton({this.onTap, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 230, 230, 230),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Visibility(
              visible: title != null,
              child: const SizedBox(width: 8),
            ),
            Visibility(
              visible: title != null,
              child: Text(
                "$title",
                style: const TextStyle(fontSize: 10, color: Color.fromARGB(255, 99, 99, 99)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
