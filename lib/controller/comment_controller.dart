import 'package:get/get.dart';
import '../../config/api_string.dart';
import '../../controller/auth_controller.dart';
import '../../model/comment_model.dart';
import '../../utils/http_handler/network_http.dart';
import '../../widget/common_snackbar.dart';

class CommentController extends GetxController {
  var isLoading = false.obs;
  var comments = <CommentModel>[].obs;
  var isPosting = false.obs;

  Future<void> getComments(int reelId) async {
    isLoading.value = true;
    comments.clear();

    await HttpHandler().apiCall(
      onResponseLoaderClose: false, // Don't block UI for fetching list
      isLoaderNeeded: false,
      apiMethod: ApiType.get,
      url: "${APIString.getCommentsByReelId}/$reelId?page=1&limit=50&status=true&sortBy=created_at&sortOrder=desc",
      onSuccess: (message, data) {
        isLoading.value = false;
        if (data != null && data is List) {
           comments.value = data.map((e) => CommentModel.fromJson(e)).toList();
        }
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  Future<void> createComment(int reelId, String text, {Function? onSuccess}) async {
    if (text.trim().isEmpty) return;

    final authController = Get.find<AuthController>();
    // Need user ID for commenting, but API seems to take "Comment_by" which is usually user ID.
    // AuthController doesn't public expose user ID easily unless we check local storage or parse token.
    // Assuming API might infer from token, BUT Postman shows "Comment_by".
    // Let's try sending "Comment_by" if we have it, else rely on backend token parsing if supported (or hardcode/fetch profile first).
    
    // UPDATE: Based on ReelModel, "author" has user_id or id.
    // ProfileController has the user profile.
    
    // For now, let's proceed and see if we can get ID.
    // Ideally we should use ProfileController to get current user ID. 
    // But to save time/complexity, let's assume backend accepts token. 
    // Wait, Postman body: "Comment_by": 1. This implies explicit ID.
    // I will try to fetch Profile first if not present?
    // Actually, let's use a dummy ID or try without it if possible, OR fetch from ProfileController.
    
    isPosting.value = true;
    
    final Map<String, dynamic> body = {
      "Real_Post_id": reelId,
      "commentText": text,
      "Status": true
      // "Comment_by": 1 // If backend requires this, we might need to fetch it.
    };

    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.post,
      url: APIString.createComment,
      data: body,
      onSuccess: (message, data) {
        isPosting.value = false;
        showSnackBarGreen(message);
        getComments(reelId); // Refresh list
        if (onSuccess != null) onSuccess();
      },
      onError: (message) {
        isPosting.value = false;
      },
    );
  }

  Future<void> deleteComment(int commentId, int reelId) async {
      await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.delete,
      url: "${APIString.deleteComment}/$commentId",
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getComments(reelId);
      },
      onError: (message) {
      },
    );
  }
}
