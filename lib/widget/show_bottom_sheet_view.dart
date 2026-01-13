import 'package:flutter/material.dart';

Future<T?> showBottomSheetView<T>({required Widget child, required BuildContext context}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // optional
    builder: (context) {
      return child;
    },
  );
}
