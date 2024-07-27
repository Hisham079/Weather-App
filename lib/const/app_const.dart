import 'package:flutter/material.dart';

verticalSpace(double size) {
  return SizedBox(
    width: size,
  );
}

horizontalSpace(double size) {
  return SizedBox(
    height: size,
  );
}

void showErrorDialog(BuildContext context, String message) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  });
}
