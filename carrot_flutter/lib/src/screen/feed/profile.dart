import 'package:carrot_flutter/src/screen/auth/intro.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            height: 800,
            width: 180,
          ),
          SizedBox(
            //width: double.infinity,
            width: 150,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5B9DFF),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) => Intro(),
                  ),
                );
              },
              child: Text('로그아웃'),
            ),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     // 버튼이 눌렸을 때 수행할 동작 추가
          //     Navigator.of(context).push(MaterialPageRoute(
          //       builder: (builder) => Intro(),
          //     ));
          //   },
          //   child: Text('로그아웃'),
          // ),
        ],
      ),
    );
  }
}
