// import 'package:workmanager/workmanager.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'notification_service.dart';
//
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final prefs = await SharedPreferences.getInstance();
//     final orders = prefs.getStringList('orders') ?? [];
//
//     final now = DateTime.now();
//     final notificationService = NotificationService();
//     await notificationService.initialize();
//
//     for (var orderJson in orders) {
//       final order = json.decode(orderJson);
//       final deliveryDate = DateTime.parse(order['date']);
//       final twoDaysBefore = deliveryDate.subtract(const Duration(days: 2));
//
//       if (now.isAfter(twoDaysBefore) && now.isBefore(deliveryDate)) {
//         await notificationService.scheduleNotification(
//           id: deliveryDate.millisecondsSinceEpoch ~/ 1000,
//           title: 'Upcoming Order Delivery',
//           body: 'Your order is scheduled for delivery on ${order['date']}',
//           scheduledDate: twoDaysBefore,
//         );
//       }
//     }
//
//     return true;
//   });
// }