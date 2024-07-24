import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:carrot_flutter/src/screens/feed/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/more_bottom.dart';
import 'screens/feed/index.dart';

final List<BottomNavigationBarItem> myTabs = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: '홈',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.feed),
    label: '동네',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.chat_bubble_outline_rounded),
    label: '채팅',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    label: '마이',
  ),
];

final List<Widget> myTabItems = [
  FeedIndex(),
  Center(child: Text('동네')),
  Center(child: Text('채팅')),
  Center(child: Text('마이')),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userController = Get.put(UserController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    userController.myInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: myTabs,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: myTabItems,
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: myTabs.length,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         centerTitle: false,
  //         title: Text('내 동네'),
  //         actions: [
  //           IconButton(
  //             onPressed: () {},
  //             icon: Icon(Icons.search),
  //           ),
  //           IconButton(
  //             onPressed: () {},
  //             icon: Icon(Icons.notifications_none_rounded),
  //           ),
  //         ],
  //         bottom: TabBar(tabs: myTabs),
  //       ),
  //       body: TabBarView(children: myTabItems),
  //     ),
  //   );
  // }

