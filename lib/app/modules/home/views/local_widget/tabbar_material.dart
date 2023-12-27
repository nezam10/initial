import 'package:flutter/material.dart';

import '../../../../core/values/app_colors.dart';

class TabBarMaterialWidget extends StatelessWidget {
  final int selectIndex;
  final ValueChanged<int> onChangedTab;
  const TabBarMaterialWidget({
    super.key,
    required this.selectIndex,
    required this.onChangedTab,
  });

  @override
  Widget build(BuildContext context) {
    const placeholder = Opacity(
      opacity: 0,
      child:
          IconButton(icon: Icon(Icons.arrow_drop_up_outlined), onPressed: null),
    );

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6,
      color: Colors.grey.shade800,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTabItem(index: 0, icon: const Icon(Icons.home), name: "Home"),
            buildTabItem(
                index: 1, icon: const Icon(Icons.favorite), name: "Favorite"),
            placeholder,
            buildTabItem(
                index: 2,
                icon: const Icon(Icons.shopping_basket),
                name: "Purchase"),
            buildTabItem(
                index: 3, icon: const Icon(Icons.video_call), name: "Meeting"),
          ],
        ),
      ),
    );
  }

  Widget buildTabItem({
    required int index,
    required Icon icon,
    required String name,
  }) {
    final isSelected = index == selectIndex;

    return IconTheme(
      data: IconThemeData(
        color: isSelected ? AppColors.white : Colors.grey,
      ),
      child: MaterialButton(
        minWidth: 40,
        //icon: icon,

        onPressed: () => onChangedTab(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              color: isSelected ? AppColors.white : Colors.grey,
            ),
            Text(
              name,
              style: TextStyle(
                color: isSelected ? AppColors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
