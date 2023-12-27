import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/theme/theme_service.dart';
import '../core/values/app_colors.dart';
import '../modules/home/controllers/home_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            width: double.infinity,
            //color: AppColors.appcolor,
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: const AssetImage("assets/images/apartments4.jpg"),
              //   fit: BoxFit.cover,
              //   colorFilter: ColorFilter.mode(
              //       Colors.black.withOpacity(0.2), BlendMode.dstIn),
              // ),
              color: AppColors.appcolor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      const AssetImage("assets/images/profile.jpg"),
                  backgroundColor: Colors.blue.withOpacity(0.5),
                ),
                const SizedBox(height: 6),
                const Text(
                  'No Name',
                  style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                ),
                const Text(
                  'No Email Address',
                  style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.white),
                )
              ],
            ),
          ),
          drawerMenuItem(context, homeController),
        ],
      ),
    );
  }

  drawerMenuItem(BuildContext context, HomeController homeController) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuItemWithClick(
                itemName: 'Profile',
                icon: Icons.person,
                onClick: () {
                  Get.back();
                  print("Click");
                },
              ),
              MenuItemWithClick(
                itemName: 'Favorite',
                icon: Icons.favorite,
                onClick: () {
                  Navigator.of(context).pop();
                  homeController.selectedIndex = 1;
                  homeController.updateState();
                },
              ),
              MenuItemWithClick(
                itemName: 'Theme',
                icon: Icons.bedtime_rounded,
                onClick: () {
                  Navigator.of(context).pop();
                  ThemeService().switchTheme();
                  homeController.statusBarTheme();
                },
              ),
              MenuItemWithClick(
                itemName: 'Saved Brokers',
                icon: Icons.save_rounded,
                onClick: () {
                  Navigator.of(context).pop();
                  print("Click");
                },
              ),
              MenuItemWithClick(
                itemName: 'Property Document',
                icon: Icons.library_books_rounded,
                onClick: () {
                  print("Click");
                },
              ),
              const SizedBox(height: 15),
              const Text("LEGALS & SUPPORT"),
              const Divider(color: Colors.grey, height: 30),
              MenuItemWithClick(
                itemName: 'About Us ',
                icon: Icons.account_box_outlined,
                onClick: () {
                  print('Testing2');
                  print("Click");
                },
              ),
              MenuItemWithClick(
                itemName: 'Contact Us',
                icon: Icons.contact_phone,
                onClick: () {
                  print('Testing1');
                  print("Click");
                },
              ),
              MenuItemWithClick(
                itemName: 'Terms & Conditions',
                icon: Icons.event_note_sharp,
                onClick: () {
                  print(' Terms & Conditions Page ');
                  print("Click");
                },
              ),
              MenuItemWithClick(
                itemName: 'Privacy Policy',
                icon: Icons.privacy_tip,
                onClick: () {
                  print(' Privacy Policy Page ');

                  print("Click");
                },
              ),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemWithClick extends StatelessWidget {
  final String itemName;
  final IconData icon;
  //Function onClick;
  final void Function()? onClick;
  const MenuItemWithClick({
    Key? key,
    required this.itemName,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
      visualDensity: const VisualDensity(vertical: -3),
      horizontalTitleGap: 10,
      minLeadingWidth: 0,
      minVerticalPadding: 0,
      title: Text(itemName, textAlign: TextAlign.left),
      leading: Icon(icon, color: Colors.green),
      onTap: onClick
      /*{
        Get.toNamed(Routes.FAQ);
      }*/
      ,
    );
  }
}
