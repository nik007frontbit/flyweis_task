import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_text_style.dart';
import '../../controller/story_controller.dart';
import '../../model/story_model.dart';
import '../../widget/app_button.dart';
import '../../widget/common_textfield.dart';

class CreateStoryView extends StatefulWidget {
  final StoryModel? story;

  const CreateStoryView({Key? key, this.story}) : super(key: key);

  @override
  _CreateStoryViewState createState() => _CreateStoryViewState();
}

class _CreateStoryViewState extends State<CreateStoryView> {
  final StoryController storyController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.story != null) {
      titleController.text = widget.story!.title ?? "";
      descriptionController.text = widget.story!.discription ?? "";
      if (widget.story!.image != null && widget.story!.image!.isNotEmpty) {
          imageController.text = widget.story!.image!.first;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story == null ? "Create Story" : "Edit Story", style: AppTextStyle.regular700.copyWith(color: Colors.black)),
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
              hintText: "Enter story title",
              controller: titleController,
            ),
            CommonTextField(
              title: "Description",
              hintText: "What's happening?",
              controller: descriptionController,
              maxLine: 5,
            ),
            CommonTextField(
              title: "Image URL",
              hintText: "https://example.com/story.png",
              controller: imageController,
            ),
            const SizedBox(height: 40),
            CommonButton(
              title: widget.story == null ? "Post Story" : "Update Story",
              onTap: () {
                if(titleController.text.isEmpty) {
                    Get.snackbar("Error", "Title required");
                    return;
                }
                
                final storyData = StoryModel(
                    title: titleController.text,
                    discription: descriptionController.text,
                    image: imageController.text.isNotEmpty ? [imageController.text] : [],
                    status: true,
                    emozi: "😊", 
                );

                if (widget.story == null) {
                  storyController.createStory(storyData, onSuccess: () {
                      Get.back();
                  });
                } else {
                   final Map<String, dynamic> updateData = {
                       "title": titleController.text,
                       "Discription": descriptionController.text,
                       "image": imageController.text.isNotEmpty ? [imageController.text] : [],
                   };
                   
                   if (widget.story!.id != null) {
                       storyController.updateStory(widget.story!.id!, updateData, onSuccess: () {
                          Get.back();
                       });
                   } else {
                       Get.snackbar("Error", "Look like this story has invalid ID");
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
