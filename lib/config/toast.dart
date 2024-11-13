import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class Toast {
  static void showInfo(
    BuildContext context,
    String message,
  ) {
    _showFlash(
      context,
      message,
      Colors.blue,
      Colors.white,
      'Information',
    );
  }

  static void showSuccess(
    BuildContext context,
    String message,
  ) {
    _showFlash(
      context,
      message,
      Colors.green,
      Colors.white,
      'Success',
    );
  }

  static void showError(
    BuildContext context,
    String errorMessage,
  ) {
    _showFlash(
      context,
      errorMessage,
      Colors.red,
      Colors.white,
      'Error',
    );
  }

  static void _showFlash(
    BuildContext context,
    String message,
    Color backgroundColor,
    Color borderColor,
    String title,
  ) {
    showFlash(
      context: context,
      duration: const Duration(seconds: 3),
      builder: (_, controller) {
        return FlashBar(
          controller: controller,
          position: FlashPosition.top,
          backgroundColor: backgroundColor,
          icon: Icon(
            Icons.info,
            color: borderColor,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: borderColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: borderColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          primaryAction: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => controller.dismiss(),
              icon: Icon(
                Icons.clear,
                color: borderColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
