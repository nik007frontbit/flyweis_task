import 'package:get/get.dart';
import '../config/api_string.dart';
import '../model/story_model.dart';
import '../utils/http_handler/network_http.dart';
import '../widget/common_snackbar.dart';

class StoryController extends GetxController {
  var isLoading = false.obs;
  var stories = <StoryModel>[].obs;
  var currentPage = 1;
  var hasMore = true;

  @override
  void onInit() {
    super.onInit();
    getAllStories();
  }

  Future<void> getAllStories({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
      hasMore = true;
      stories.clear();
    }

    if (!hasMore) return;

    isLoading.value = true;

    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.get,
      url: "${APIString.getAllStories}?page=$currentPage&limit=10&status=true&sortBy=created_at&sortOrder=desc",
      onSuccess: (message, data) {
        isLoading.value = false;
        if (data != null && data is List) {
          final newStories = data.map((e) => StoryModel.fromJson(e)).toList();
          if (newStories.length < 10) {
            hasMore = false;
          }
          stories.addAll(newStories);
          currentPage++;
        }
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  Future<void> createStory(StoryModel story, {Function? onSuccess}) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.post,
      url: APIString.createStory,
      data: story.toJson(),
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getAllStories(isRefresh: true);
        if (onSuccess != null) onSuccess();
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }

  Future<void> updateStory(int id, Map<String, dynamic> data, {Function? onSuccess}) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.put,
      url: "${APIString.updateStory}/$id",
      data: data,
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getAllStories(isRefresh: true);
        if (onSuccess != null) onSuccess();
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }

  Future<void> deleteStory(int id) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.delete,
      url: "${APIString.deleteStory}/$id",
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getAllStories(isRefresh: true);
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }
}
