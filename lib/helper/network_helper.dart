// import 'dart:io';
// import 'package:flutter/material.dart';

// class NetworkExceptionHandler {
//   void handleException(dynamic e) {
//     if (e is SocketException) {
//       print('Network error: $e');
//       // Show a network error dialog
//       showAlertDialog(
//         title: 'Network Error',
//         message:
//             'Network error occurred. Please check your internet connection.',
//       );
//     } else if (e is CustomPermissionDeniedException) {
//       showAlertDialog(
//         title: 'Permission Denied',
//         message:
//             'Location permissions are denied. Please enable them in settings.',
//       );
//     } else if (e is PermissionDeniedForeverException) {
//       showAlertDialog(
//         title: 'Permission Denied Forever',
//         message:
//             'Location permissions are permanently denied. Please enable them in settings.',
//       );
//     } else if (e is CustomLocationServiceDisabledException) {
//       showAlertDialog(
//         title: 'Location Service Disabled',
//         message:
//             'Location services are disabled. Please enable them in settings.',
//       );
//     } else {
//       print('An error occurred: $e');
//       // Show a general error dialog
//       showAlertDialog(
//         title: 'Error',
//         message: 'Oops, something went wrong.',
//       );
//     }
//   }

//   void showAlertDialog({required String title, required String message}) {
//     Get.defaultDialog(
//       title: title,
//       middleText: message,
//       confirm: TextButton(
//         onPressed: () => Get.back(),
//         child: Text('OK'),
//       ),
//     );
//   }

//   void showMessage({required String title, required String message}) {
//     Get.defaultDialog(
//       contentPadding: EdgeInsets.symmetric(horizontal: 25),
//       title: title,
//       middleText: message,
//       middleTextStyle: TextStyle(color: Colors.blueGrey, fontSize: 13),
//       confirm: TextButton(
//         onPressed: () => Get.back(),
//         child: Text('OK'),
//       ),
//     );
//   }
// }

// // Custom exceptions for clarity
// class CustomPermissionDeniedException implements Exception {
//   final String message;

//   CustomPermissionDeniedException([this.message = 'Permission denied.']);

//   @override
//   String toString() => message;
// }

// class PermissionDeniedForeverException implements Exception {
//   final String message;

//   PermissionDeniedForeverException(
//       [this.message = 'Permission denied forever.']);

//   @override
//   String toString() => message;
// }

// class CustomLocationServiceDisabledException implements Exception {
//   final String message;

//   CustomLocationServiceDisabledException(
//       [this.message = 'Location services are disabled.']);

//   @override
//   String toString() => message;
// }
