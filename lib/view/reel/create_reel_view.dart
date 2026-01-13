import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_text_style.dart';
import '../../controller/reel_controller.dart';
import '../../model/reel_model.dart';
import '../../widget/app_button.dart';
import '../../widget/common_textfield.dart';

class CreateReelView extends StatefulWidget {
  final ReelModel? reel;

  const CreateReelView({Key? key, this.reel}) : super(key: key);

  @override
  _CreateReelViewState createState() => _CreateReelViewState();
}

class _CreateReelViewState extends State<CreateReelView> {
  final ReelController reelController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.reel != null) {
      titleController.text = widget.reel!.title ?? "";
      descriptionController.text = widget.reel!.discription ?? "";
      if (widget.reel!.image != null && widget.reel!.image!.isNotEmpty) {
          imageController.text = widget.reel!.image!.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reel == null ? "Create Post" : "Edit Post", style: AppTextStyle.regular700.copyWith(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CommonTextField(
              title: "Title",
              hintText: "Enter post title",
              controller: titleController,
            ),
            CommonTextField(
              title: "Description",
              hintText: "What's on your mind?",
              controller: descriptionController,
              maxLine: 5,
            ),
            CommonTextField(
              title: "Image URL",
              hintText: "https://example.com/image.png",
              controller: imageController,
            ),
            const SizedBox(height: 40),
            CommonButton(
              title: widget.reel == null ? "Post" : "Update",
              onTap: () {
                if(titleController.text.isEmpty) {
                    Get.snackbar("Error", "Title required");
                    return;
                }
                
                final reelData = ReelModel(
                    title: titleController.text,
                    discription: descriptionController.text, // note typo in API model
                    image: imageController.text.isNotEmpty ? [imageController.text] : [],
                    status: true,
                    reelType: "Post",
                    emozi: "😊", 
                );

                if (widget.reel == null) {
                  reelController.createReel(reelData, onSuccess: () {
                      Get.back();
                  });
                } else {
                   // For update, we usually send map of changed fields
                   final Map<String, dynamic> updateData = {
                       "title": titleController.text,
                       "Discription": descriptionController.text,
                       "image": imageController.text.isNotEmpty ? [imageController.text] : [],
                   };
                   
                   if (widget.reel!.id != null) {
                       reelController.updateReel(widget.reel!.id!, updateData, onSuccess: () {
                          Get.back();
                       });
                   } else {
                       Get.snackbar("Error", "Look like this post has valid ID");
                   }
                }
              },
              isShadow: true,
            )
          ],
        ),
      ),
    );
  }
}
