import 'package:carrot_flutter/src/screen/feed/create.dart';
import 'package:carrot_flutter/src/screen/feed/index.dart';
import 'package:carrot_flutter/src/screen/feed/profile.dart';
// import 'package:carrot_flutter/src/widget/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Image.asset(
                    'asset/logo-copy.png',
                    width: 150,
                    height: 100,
                  ),
                )
              ],
            )),
        floatingActionButton: InkWell(
          onTap: () {
            Get.to(() => feedCreate());
          },
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: const ShapeDecoration(
              shape: StadiumBorder(),
              color: Color(0xff5B9DFF),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        bottomNavigationBar: const SafeArea(
            child: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home), text: '홈'),
            // Tab(icon: Icon(Icons.feed), text: '동네생활'),
            // Tab(icon: Icon(Icons.location_on_outlined), text: '내 근처'),
            // Tab(icon: Icon(Icons.chat_bubble_outline_rounded), text: '채팅'),
            Tab(icon: Icon(Icons.person_outline), text: '프로필'),
          ],
        )),
        body: const TabBarView(
          children: [
            FeedIndex(),
            Profile(),
            // Center(child: Text('page2')),
            // Center(child: Text('page3')),
            // Center(child: Text('page4')),
            // Center(child: Text('page5')),
          ],
        ),
      ),
    );
  }
}
