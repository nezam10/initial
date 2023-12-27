import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  final testTextEditCon = TextEditingController();
  final count = 0.obs;
  int selectedIndex = 0;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void updateState() => update();

  // systemNavigationBarTheme
  void statusBarTheme() {
    Get.isDarkMode
        ? SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black,
            ),
          )
        : SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black,
            ),
          );
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> navigationScreen = <Widget>[
    SizedBox(
      height: Get.height,
      width: Get.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Index 0: 00',
              style: optionStyle,
            ),
          ],
        ),
      ),
    ),
    const Text('Index 1: 11', style: optionStyle),
    const Text('Index 2: 22', style: optionStyle),
    const Text('Index 3: 33', style: optionStyle),
  ];

  // Method
  void onItemTapped(int index) {
    selectedIndex = index;
    update();
  }

  void incrementTab(index) {
    print('floating button');
    print(index);
  }
}
