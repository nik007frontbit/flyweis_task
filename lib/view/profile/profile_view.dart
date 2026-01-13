import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';
import '../../controller/auth_controller.dart';
import '../../controller/profile_controller.dart';
import '../../widget/app_button.dart';
import '../../widget/catched_network_image.dart';

class ProfileView extends StatelessWidget {
  final ProfileController profileController = Get.put(ProfileController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      body: SafeArea(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = profileController.user.value;

          return Column(
            children: [
               Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                      Container(
                          height: 200,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight
                              ),
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30))
                          ),
                      ),
                      Transform.translate(
                          offset: const Offset(0, 50),
                          child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: (user?.profileImage != null) 
                                      ? NetworkImage(user!.profileImage!) 
                                      : null,
                                  child: (user?.profileImage == null) 
                                      ? const Icon(Icons.person, size: 60, color: Colors.grey) 
                                      : null,
                              ),
                          ),
                      )
                  ],
               ),
               const SizedBox(height: 60),
               
               Text(
                   "${user?.firstName ?? 'User'} ${user?.lastName ?? ''}",
                   style: AppTextStyle.regular700.copyWith(fontSize: 24),
               ),
               Text(
                   user?.email ?? "",
                   style: AppTextStyle.regular400.copyWith(fontSize: 16, color: Colors.grey),
               ),
               const SizedBox(height: 30),
               
               // Info Cards
               Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24),
                   child: Column(
                       children: [
                           _infoTile(Icons.phone, "Phone", user?.phoneNo ?? "N/A"),
                           _infoTile(Icons.verified, "Role", user?.role ?? "User"),
                           _infoTile(Icons.card_membership, "Plan ID", user?.planId?.toString() ?? "Free"),
                       ],
                   ),
               ),
               
               const Spacer(),
               Padding(
                   padding: const EdgeInsets.all(24),
                   child: CommonButton(
                       title: "Logout",
                       backColor: Colors.red[50],
                       textColor: Colors.red,
                       onTap: () {
                           authController.logout();
                       },
                   ),
               ),
               const SizedBox(height: 20),
            ],
          );
        }),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
      return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 5)
                  )
              ]
          ),
          child: Row(
              children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(icon, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(title, style: AppTextStyle.regular400.copyWith(fontSize: 12, color: Colors.grey)),
                          Text(value, style: AppTextStyle.regular700.copyWith(fontSize: 16)),
                      ],
                  )
              ],
          ),
      );
  }
}
