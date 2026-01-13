import 'package:flutter/material.dart';

// bottomsheet round shape
RoundedRectangleBorder roundRectangleShape() {
  return const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  );
}
