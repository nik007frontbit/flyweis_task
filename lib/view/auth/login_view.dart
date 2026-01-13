import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_colors.dart';
import '../../config/app_text_style.dart';
import '../../controller/auth_controller.dart';
import '../../widget/app_button.dart';
import '../../widget/common_textfield.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final RxBool isOtpSent = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                "Welcome Back",
                style: AppTextStyle.regular700.copyWith(
                  fontSize: 28,
                  color: AppColors.blackColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Please login to continue using the app.",
                style: AppTextStyle.regular400.copyWith(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              CommonTextField(
                title: "Phone Number",
                hintText: "Enter your phone number",
                controller: phoneController,
                textInputType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_android),
              ),
               Obx(() => isOtpSent.value
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        CommonTextField(
                          title: "OTP",
                          hintText: "Enter OTP",
                          controller: otpController,
                          textInputType: TextInputType.number,
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const Spacer(),
              Obx(() => CommonButton(
                title: isOtpSent.value ? "Verify & Login" : "Send OTP",
                onTap: () {
                  if (isOtpSent.value) {
                    if (otpController.text.isNotEmpty) {
                      authController.verifyOtp(
                          phoneController.text, otpController.text);
                    } else {
                      Get.snackbar("Error", "Please enter OTP");
                    }
                  } else {
                    if (phoneController.text.isNotEmpty) {
                      authController.sendOtp(phoneController.text, onSuccess: (otp) {
                         isOtpSent.value = true;
                         if (otp != null) {
                           print("TESTING: Received OTP: $otp");
                           Get.snackbar("Testing", "OTP is $otp", backgroundColor: Colors.yellow);
                         } 
                      });
                    } else {
                      Get.snackbar("Error", "Please enter phone number");
                    }
                  }
                },
                isShadow: true,
              )),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
