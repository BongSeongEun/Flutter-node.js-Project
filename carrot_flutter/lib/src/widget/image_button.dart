import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback? onTap;

  const ImageButton({Key? key, this.onTap, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xff5B9DFF), width: 2.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: imageUrl == null // 이미지가 없으면
              ? const Icon(
                  // 아이콘을 배정
                  Icons.camera_alt_outlined,
                  size: 40.0,
                  color: Color(0xff5B9DFF),
                )
              : Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: 80.0,
                  height: 80.0,
                ),
        ),
      ),
    );
  }
}
