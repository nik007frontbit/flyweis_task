// import 'dart:io';
//
// import 'package:flutter/foundation.dart'; // <-- for kIsWeb
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart';
// import 'package:pos_system/config/app_colors.dart';
// import 'package:pos_system/widget/common_snackbar.dart';
//
// class ImageUtils {
//   static Future<File?> pickCropCompressImage(
//     ImageSource source, {
//     bool isOriginalOn = false,
//     BuildContext? context,
//   }) async {
//     try {
//       final picker = ImagePicker();
//       final XFile? picked = await picker.pickImage(source: source);
//       if (picked == null) return null;
//
//       // Special handling for Web: No File(), no real path
//       if (kIsWeb) {
//         final CroppedFile? croppedFile = await ImageCropper().cropImage(
//           sourcePath: picked.path,
//           compressFormat: ImageCompressFormat.jpg,
//           uiSettings: [WebUiSettings(context: context ?? Get.context!)],
//         );
//
//         if (croppedFile == null) return null;
//
//         // ❗ On Web: Can't compress to File. Only returns bytes.
//         // You must handle bytes upload directly.
//         showSnackBarRed("Feature is available on Mobile App Only.");
//         return null; // or return a fake File if needed
//       }
//
//       // -------- Mobile logic below --------
//       final File pickedFile = File(picked.path);
//
//       final CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: pickedFile.path,
//         compressFormat: ImageCompressFormat.jpg,
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: "Crop Image",
//             toolbarColor: AppColors.primary,
//             toolbarWidgetColor: Colors.white,
//             activeControlsWidgetColor: AppColors.primary,
//             statusBarColor: AppColors.primary,
//             initAspectRatio: isOriginalOn ? CropAspectRatioPreset.original : CropAspectRatioPreset.square,
//             lockAspectRatio: false,
//             aspectRatioPresets: [
//               if (isOriginalOn) CropAspectRatioPreset.original,
//               CropAspectRatioPreset.square,
//               CropAspectRatioPreset.ratio3x2,
//               CropAspectRatioPreset.ratio5x3,
//               CropAspectRatioPreset.ratio16x9,
//             ],
//           ),
//           IOSUiSettings(
//             title: "Crop Image",
//             aspectRatioLockEnabled: false,
//             aspectRatioPresets: [
//               if (isOriginalOn) CropAspectRatioPreset.original,
//               CropAspectRatioPreset.square,
//               CropAspectRatioPreset.ratio3x2,
//               CropAspectRatioPreset.ratio5x3,
//               CropAspectRatioPreset.ratio16x9,
//             ],
//           ),
//         ],
//       );
//
//       if (croppedFile == null) return null;
//
//       // Compress to 600x600
//       final tempDir = await getTemporaryDirectory();
//       final targetPath = path.join(tempDir.path, '${DateTime.now().millisecondsSinceEpoch}_600x600.jpg');
//
//       final XFile? compressed = await FlutterImageCompress.compressAndGetFile(
//         croppedFile.path,
//         targetPath,
//         minWidth: 500,
//         minHeight: 500,
//         quality: 80,
//         format: CompressFormat.jpeg,
//       );
//
//       return File(compressed?.path ?? croppedFile.path);
//     } catch (e) {
//       debugPrint("Error in pickCropCompressImage: $e");
//       return null;
//     }
//   }
// }
