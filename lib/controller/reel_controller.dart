import 'package:get/get.dart';
import '../config/api_string.dart';
import '../model/reel_model.dart';
import '../utils/http_handler/network_http.dart';
import '../widget/common_snackbar.dart';

class ReelController extends GetxController {
  var isLoading = false.obs;
  var reelList = <ReelModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllReels();
  }

  Future<void> getAllReels({bool isRefresh = false}) async {
    if(!isRefresh) isLoading.value = true;

    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.get,
      url: "${APIString.getAllReels}?page=1&limit=50&status=true&sortBy=created_at&sortOrder=desc",
      onSuccess: (message, data) {
        // Handle variations in data structure
        if (data is List) {
           reelList.value = data.map((e) => ReelModel.fromJson(e)).toList();
        } else if (data['docs'] != null && data['docs'] is List) {
           reelList.value = (data['docs'] as List).map((e) => ReelModel.fromJson(e)).toList();
        } else {
           // Fallback or empty
        }
        
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
      },
    );
  }

  Future<void> createReel(ReelModel reel, {Function? onSuccess}) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.post,
      url: APIString.createReel,
      data: reel.toJson(),
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getAllReels(isRefresh: true);
        if (onSuccess != null) onSuccess();
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }

  Future<void> updateReel(int id, Map<String, dynamic> data, {Function? onSuccess}) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.put,
      url: "${APIString.updateReel}/$id",
      data: data,
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getAllReels(isRefresh: true);
        if (onSuccess != null) onSuccess();
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }

  Future<void> deleteReel(int id) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.delete,
      url: "${APIString.deleteReel}/$id",
      onSuccess: (message, data) {
        showSnackBarGreen(message);
        getAllReels(isRefresh: true);
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }

  // --- Reel Share APIs ---

  Future<void> shareReel(int reelId) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.post,
      url: APIString.createReelShare,
      data: {
        "Real_Post_id": reelId,
        "share_by": 1, 
        "Status": true
      },
      onSuccess: (message, data) {
        showSnackBarGreen("Reel shared successfully");
      },
      onError: (message) {
        // Error handled in HttpHandler
      },
    );
  }

  Future<void> getAllShares() async {
     await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.get,
      url: "${APIString.getAllReelShares}?page=1&limit=50",
      onSuccess: (message, data) {
        // Just fetching for integration proof
      },
      onError: (message) {
        // Handle error
      },
    );
  }

  Future<void> deleteShare(int shareId) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.delete,
      url: "${APIString.deleteReelShare}/$shareId",
      onSuccess: (message, data) {
         showSnackBarGreen("Share deleted");
      },
      onError: (message) {
         // Error handled in HttpHandler
      },
    );
  }
}
