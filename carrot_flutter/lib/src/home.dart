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
    icon: Icon(Icons.person_outline),
    label: '마이',
  ),
];

final List<Widget> myTabItems = [
  FeedIndex(),
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
        selectedItemColor: Color.fromARGB(255, 255, 198, 40),
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