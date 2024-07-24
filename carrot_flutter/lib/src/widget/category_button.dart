import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final String? title;

  const CategoryButton({this.onTap, required this.icon, this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Icon(
                Icons.person_search,
                size: 16,
                color: Colors.grey[600],
              ),
            ),
            Visibility(
              visible: title != null,
              child: const SizedBox(width: 8),
            ),
            Visibility(
              visible: title != null,
              child: Text(
                "$title",
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            )
            // const SizedBox(width: 8),
            // Text(
            //   '알바',
            //   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            // )
          ],
        ),
      ),
    );
  }
}
