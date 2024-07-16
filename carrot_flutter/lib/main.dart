import 'package:carrot_flutter/src/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'src/app.dart';

void main() async {
  // GetStorage 사용을 위한 초기화
  await GetStorage.init();

  // 로그인 여부 체크 (토큰이 있는지 확인)
  final userController = Get.put(UserController());
  bool isLogin = await userController.isLogin();

  runApp(MyApp(isLogin));
}

// class MyApp extends StatelessWidget {
//   // 상태값이 없는 위젯
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   // 상태값을 갖는 위젯
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 5,
  //     child: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Colors.white,
  //         title: const Text('정왕동'),
  //         centerTitle: false,
  //         actions: const [
  //           IconButton(onPressed: null, icon: Icon(Icons.menu)),
  //           IconButton(onPressed: null, icon: Icon(Icons.search)),
  //           IconButton(onPressed: null, icon: Icon(Icons.notification_add)),
  //         ],
  //       ),
  //       bottomNavigationBar: const SafeArea(
  //           child: TabBar(
  //         tabs: [
  //           Tab(icon: Icon(Icons.home), text: '홈'),
  //           Tab(icon: Icon(Icons.feed), text: '동네생활'),
  //           Tab(icon: Icon(Icons.location_on_outlined), text: '내 근처'),
  //           Tab(icon: Icon(Icons.chat_bubble_outline_rounded), text: '채팅'),
  //           Tab(icon: Icon(Icons.person_outline), text: '나의 홍당무'),
  //         ],
  //       )),
  //       body: const TabBarView(
  //         children: [
  //           Center(child: Text('page1')),
  //           Center(child: Text('page2')),
  //           Center(child: Text('page3')),
  //           Center(child: Text('page4')),
  //           Center(child: Text('page5')),
  //         ],
  //       ),
  //     ),
  //   );
  // }
// }
