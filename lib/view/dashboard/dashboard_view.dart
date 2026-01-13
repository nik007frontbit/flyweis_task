import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';
import 'package:flyweis_task/view/reel/reel_list_view.dart';
import '../story/story_list_view.dart';
import '../profile/profile_view.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}

class DashboardView extends StatelessWidget {
  final DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: dashboardController.tabIndex.value,
        children: [
          ReelListView(),
          StoryListView(),
          ProfileView(),
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.primary,
        onTap: dashboardController.changeTabIndex,
        currentIndex: dashboardController.tabIndex.value,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        items: [
          _bottomNavigationBarItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          _bottomNavigationBarItem(
            icon: Icons.auto_stories_outlined,
            activeIcon: Icons.auto_stories,
            label: 'Stories',
          ),
          _bottomNavigationBarItem(
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            label: 'Profile',
          ),
        ],
      )),
    );
  }

  _bottomNavigationBarItem({required IconData icon, required IconData activeIcon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: Icon(activeIcon),
      label: label,
    );
  }
}
