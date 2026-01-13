import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';

import '../config/app_colors.dart';
import '../config/app_images.dart';

class BottomSheetTitle extends StatelessWidget {
  String title;
  VoidCallback? voidCallback;

  BottomSheetTitle({super.key, required this.title, this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.fontPrimary)),
      trailing: GestureDetector(
        onTap: () {
          Get.back();
          voidCallback?.call();
        },
        child: Icon(RemixIcons.close_line, ),
      ),
    );
  }
}
