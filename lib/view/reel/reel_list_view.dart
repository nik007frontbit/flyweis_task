import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';
import '../../controller/reel_controller.dart';
import 'create_reel_view.dart';
import '../../widget/catched_network_image.dart';
import '../comment/comment_bottom_sheet.dart';

class ReelListView extends StatelessWidget {
  final ReelController reelController = Get.put(ReelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background
      appBar: AppBar(
        title: Text("Feed", style: AppTextStyle.regular700.copyWith(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
            IconButton(
                onPressed: () {
                    Get.to(() => CreateReelView());
                },
                icon: Icon(Icons.add_circle_outline, color: AppColors.primary, size: 30,)
            )
        ],
      ),
      body: Obx(() {
        if (reelController.isLoading.value && reelController.reelList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (reelController.reelList.isEmpty) {
             return Center(
                 child: Text("No posts yet.", style: AppTextStyle.regular500.copyWith(color: Colors.grey))
             );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await reelController.getAllReels(isRefresh: true);
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reelController.reelList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final reel = reelController.reelList[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    ListTile(
                      leading: Container(
                        height: 40,
                        width: 40,
                        child: CommonNetworkImage(
                           imageUrl: reel.author?.profileImage,
                           itemName: reel.author?.firstName ?? "U",
                           radius: 50,
                        ),
                      ),
                      title: Text(
                        "${reel.author?.firstName ?? 'User'} ${reel.author?.lastName ?? ''}",
                        style: AppTextStyle.regular700.copyWith(fontSize: 16),
                      ),
                      subtitle: Text(
                         reel.createdAt ?? "Just now",
                         style: AppTextStyle.regular400.copyWith(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            
                            IconButton(
                              icon: const Icon(Icons.mode_comment_outlined, color: Colors.green),
                              onPressed: () {
                                if (reel.id != null) {
                                  Get.bottomSheet(CommentBottomSheet(reelId: reel.id!));
                                }
                              },
                            ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.blue),
                            onPressed: () {
                              if (reel.id != null) {
                                reelController.shareReel(reel.id!);
                              }
                            },
                          ),
                          PopupMenuButton(
                              onSelected: (value) {
                                  if (value == 'edit') {
                                       Get.to(() => CreateReelView(reel: reel));
                                  } else if (value == 'delete') {
                                       reelController.deleteReel(reel.id!);
                                  }
                              },
                              itemBuilder: (context) => [
                                  const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                              ]
                          ),
                        ],
                      ),
                    ),
                    
                    // Content
                    if (reel.title != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                           reel.title!,
                           style: AppTextStyle.regular700.copyWith(fontSize: 18),
                        ),
                    ),
                     
                     if (reel.discription != null)
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                           reel.discription!,
                           style: AppTextStyle.regular400.copyWith(fontSize: 14, height: 1.5),
                        ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Image/Video (Placeholder logic for simplicity if multiple)
                    if (reel.image != null && reel.image!.isNotEmpty)
                       ClipRRect(
                           borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                           child: Image.network(
                               reel.image!.first,
                               height: 250,
                               width: double.infinity,
                               fit: BoxFit.cover,
                               errorBuilder: (context, error, stackTrace) => Container(
                                   height: 200, 
                                   color: Colors.grey[200],
                                   child: const Center(child: Icon(Icons.broken_image, color: Colors.grey))
                               ),
                           ),
                       )
                    else if (reel.coverImage != null)
                        ClipRRect(
                           borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                           child: Image.network(
                               reel.coverImage!,
                               height: 250,
                               width: double.infinity,
                               fit: BoxFit.cover,
                               errorBuilder: (context, error, stackTrace) => Container(
                                   height: 200, 
                                   color: Colors.grey[200],
                                   child: const Center(child: Icon(Icons.broken_image, color: Colors.grey))
                               ),
                           ),
                       )
                    else 
                       const SizedBox(height: 16), // Bottom padding if no image
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
