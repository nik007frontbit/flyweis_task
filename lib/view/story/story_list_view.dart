import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_text_style.dart';
import '../../controller/story_controller.dart';
import '../../widget/catched_network_image.dart';
import 'create_story_view.dart';

class StoryListView extends StatefulWidget {
  const StoryListView({Key? key}) : super(key: key);

  @override
  State<StoryListView> createState() => _StoryListViewState();
}

class _StoryListViewState extends State<StoryListView> {
  final StoryController storyController = Get.put(StoryController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        storyController.getAllStories();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stories", style: AppTextStyle.regular700.copyWith(fontSize: 24, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.black, size: 28),
            onPressed: () {
               Get.to(() => const CreateStoryView());
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await storyController.getAllStories(isRefresh: true);
        },
        child: Obx(() {
          if (storyController.isLoading.value && storyController.stories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (storyController.stories.isEmpty) {
            return const Center(child: Text("No stories found"));
          }

          return ListView.separated(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: storyController.stories.length + (storyController.isLoading.value ? 1 : 0),
            separatorBuilder: (c, i) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              if (index == storyController.stories.length) {
                return const Center(child: CircularProgressIndicator());
              }

              final story = storyController.stories[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            child: CommonNetworkImage(
                               imageUrl: story.author?.profileImage,
                               itemName: story.author?.firstName ?? "U",
                               radius: 50,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${story.author?.firstName ?? 'Unknown'} ${story.author?.lastName ?? ''}", style: AppTextStyle.regular700),
                              Text(story.createdAt ?? "Just now", style: AppTextStyle.regular400.copyWith(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                          const Spacer(),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(value: 'edit', child: Text("Edit")),
                              const PopupMenuItem(value: 'delete', child: Text("Delete", style: TextStyle(color: Colors.red))),
                            ],
                            onSelected: (value) {
                               if (value == 'edit') {
                                   Get.to(() => CreateStoryView(story: story));
                               } else if (value == 'delete') {
                                   if (story.id != null) {
                                       storyController.deleteStory(story.id!);
                                   }
                               }
                            },
                          )
                        ],
                      ),
                    ),
                    
                    if (story.title != null && story.title!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(story.title!, style: AppTextStyle.regular600.copyWith(fontSize: 16)),
                      ),

                    if (story.discription != null && story.discription!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Text(story.discription!, style: AppTextStyle.regular400),
                      ),
                      
                    const SizedBox(height: 12),
                    
                     if (story.image != null && story.image!.isNotEmpty)
                       CommonNetworkImage(
                           imageUrl: story.image!.first,
                           height: 250,
                           width: double.infinity,
                           radius: 20,
                           itemName: story.title,
                       )
                    else 
                       const SizedBox(height: 16),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
