import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import '../../../global_widgets/custom_drawer.dart';
import '../controllers/home_controller.dart';
import 'local_widget/tabbar_material.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return openDialog();
      },
      child: Scaffold(
        extendBody: true,
        key: controller.globalKey,
        drawer: const Drawer(
          //backgroundColor: Colors.white,
          child: CustomDrawer(),
        ),
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                controller.globalKey.currentState?.openDrawer();
                print("openDrawer");
              },
              icon: const Icon(Icons.menu)),
        ),
        body: GetBuilder<HomeController>(
          //initState: (_) {},
          builder: (_) {
            return Center(
              child: _.navigationScreen.elementAt(_.selectedIndex),
            );
          },
        ),
        bottomNavigationBar: GetBuilder<HomeController>(
          //initState: (_) {},
          builder: (controller) {
            return TabBarMaterialWidget(
              selectIndex: controller.selectedIndex,
              onChangedTab: (value) async {
                controller.onItemTapped(value);
                print("value == $value");
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          onPressed: () {
            controller.incrementTab(1);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /* ::::::::::::::::::::::: OnWillPop show dialog :::::::::::::::::::::::*/
  openDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Are Yor Sure?'),
        content: const Text('Do you want to exit this App'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
                print("android>>>>");
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}


    //
    // ElevatedButton(
    //         onPressed: () {
    //           print("Click");
    //           // Get.changeTheme(
    //           //   // Get.isDarkMode ? AppTheme().lightTheme : AppTheme().darkTheme,
    //           //   Get.isDarkMode ? ThemeData.light() : ThemeData.dark(),
    //           // );
    //           ThemeService().switchTheme();
    //         },
    //         child: const Text("Click"),
    //       )


    //
    // BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.business),
    //         label: 'Business',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.wifi_1_bar_outlined),
    //         label: '',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.school),
    //         label: 'body',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.school),
    //         label: 'body',
    //       ),
    //     ],
    //     currentIndex: controller.selectedIndex,
    //     selectedItemColor: Colors.amber[800],
    //     onTap: controller.onItemTapped,
    //   ),
