import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isSelected;

  const CategoryButton({
    required this.onPressed,
    required this.title,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 255, 198, 40)
              : const Color.fromARGB(255, 230, 230, 230),
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
                style: const TextStyle(
                    fontSize: 10, color: Color.fromARGB(255, 99, 99, 99)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
