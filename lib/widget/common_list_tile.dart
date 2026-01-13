import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../utils/other.dart';
import '../widget/catched_network_image.dart';

class CommonListTile extends StatelessWidget {
  final String imageUrl; // Can be asset path or network URL
  final String title;
  final String? subtitle;
  final int? index;
  final bool? isFromAsset;
  final Widget? leading;
  final Widget? trailing;
  VoidCallback? onTap;

  CommonListTile({
    super.key,
    required this.imageUrl,
    required this.title,
    this.subtitle,
    this.index,
    this.isFromAsset = false,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        leading: leading ??
            (!(isFromAsset ?? false)
                ? CommonNetworkImage(
                    imageUrl: imageUrl,
                    itemName: title,
                    index: index,
                    height: 60,
                    width: 60,
                    radius: 4,
                  )
                : Image.asset(imageUrl, height: 60, width: 60, fit: BoxFit.cover)),
        title: Text(
          title.capitalize(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
          ),
        ),
        subtitle: (subtitle != null && subtitle!.trim().isNotEmpty)
            ? Text(
                subtitle!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.fontGreyPrimary,
                ),
              )
            : null,
        trailing: trailing,
      ),
    );
  }
}
