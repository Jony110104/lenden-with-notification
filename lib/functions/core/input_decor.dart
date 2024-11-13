import 'package:flutter/material.dart';

class AppInputDecor {
  AppInputDecor._();
  static InputDecoration inputDecor() {
    return InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.all(15),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
