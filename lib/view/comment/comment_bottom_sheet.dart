import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_text_style.dart';
import '../../controller/comment_controller.dart';
import '../../widget/catched_network_image.dart';
import '../../widget/common_textfield.dart';

class CommentBottomSheet extends StatelessWidget {
  final int reelId;
  CommentBottomSheet({Key? key, required this.reelId}) : super(key: key);

  final CommentController commentController = Get.put(CommentController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    commentController.getComments(reelId);

    return Container(
      height: Get.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(height: 5, width: 40, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 12),
          Text("Comments", style: AppTextStyle.regular700.copyWith(fontSize: 18)),
          const Divider(),
          Expanded(
            child: Obx(() {
              if (commentController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (commentController.comments.isEmpty) {
                return const Center(child: Text("No comments yet. Be the first!"));
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: commentController.comments.length,
                separatorBuilder: (c, i) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonNetworkImage(
                        imageUrl: comment.commentBy?.profileImage,
                        itemName: comment.commentBy?.firstName ?? "U",
                        height: 40,
                        width: 40,
                        radius: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${comment.commentBy?.firstName ?? 'User'} ${comment.commentBy?.lastName ?? ''}",
                              style: AppTextStyle.regular700.copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(comment.commentText ?? "", style: AppTextStyle.regular400),
                            const SizedBox(height: 4),
                            Text(comment.createdAt ?? "", style: AppTextStyle.regular400.copyWith(fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ),
                      if (comment.id != null) // Allow delete if valid ID (add auth check later if needed)
                         IconButton(
                             icon: const Icon(Icons.delete_outline, size: 18, color: Colors.grey),
                             onPressed: () {
                                 commentController.deleteComment(comment.id!, reelId);
                             },
                         )
                    ],
                  );
                },
              );
            }),
          ),
          const Divider(height: 1),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 16, left: 16, right: 16, top: 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                        controller: textController,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: "Add a comment..."),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(() => commentController.isPosting.value 
                    ? const Padding(padding: EdgeInsets.all(8.0), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)))
                    : IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: () {
                            if (textController.text.trim().isNotEmpty) {
                                commentController.createComment(reelId, textController.text, onSuccess: () {
                                    textController.clear();
                                });
                            }
                        },
                      )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
