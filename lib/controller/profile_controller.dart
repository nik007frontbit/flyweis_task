import 'package:get/get.dart';
import '../config/api_string.dart';
import '../model/user_model.dart';
import '../utils/http_handler/network_http.dart';

class ProfileController extends GetxController {
  
  var isLoading = false.obs;
  var user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.get,
      url: APIString.getProfile,
      onSuccess: (message, data) {
        user.value = UserModel.fromJson(data);
        isLoading.value = false;
      },
      onError: (message) {
        isLoading.value = false;
        // Optionally show error or handle retry
      },
    );
  }
}
