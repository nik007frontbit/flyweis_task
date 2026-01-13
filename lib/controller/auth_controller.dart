

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_string.dart';
import '../config/local_storage.dart';
import '../model/auth_model.dart';
import '../utils/http_handler/network_http.dart';
import '../view/dashboard/dashboard_view.dart';
import '../view/auth/login_view.dart';
import '../widget/common_snackbar.dart';

class AuthController extends GetxController {
  
  var isLoading = false.obs;

  // Send OTP
  Future<void> sendOtp(String phoneNo, {Function? onSuccess}) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.post,
      url: APIString.sendOtp,
      data: {
        "phoneNo": phoneNo
      },
      onSuccess: (message, data) {
        LoginResponse response = LoginResponse.fromJson({'data': data, 'message': message});
        showSnackBarGreen(message);
        if (onSuccess != null) onSuccess(response.otp);
      },
      onError: (message) {
        showSnackBarRed(message);
      },
    );
  }

  // Verify OTP
  Future<void> verifyOtp(String phoneNo, String otp) async {
    await HttpHandler().apiCall(
      onResponseLoaderClose: true,
      apiMethod: ApiType.post,
      url: APIString.verifyOtp,
      data: {
        "phoneNo": phoneNo,
        "otp": otp
      },
      onSuccess: (message, data) async {
        VerifyOtpResponse response = VerifyOtpResponse.fromJson({'data': data, 'message': message});
        
        if (response.accessToken != null) {
          final box = GetStorage();
          await box.write(LocalStorageData.token, response.accessToken!);
          
          showSnackBarGreen("Login Successful");
          Get.offAll(() => DashboardView());
        } else {
             showSnackBarRed("Token missing in response");
        }
      },
      onError: (message) {
         showSnackBarRed(message);
      },
    );
  }

  // Logout
  Future<void> logout() async {
     final box = GetStorage();
     await box.erase();
     Get.offAll(() => LoginView());
  }
}
