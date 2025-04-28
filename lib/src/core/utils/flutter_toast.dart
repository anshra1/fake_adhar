import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Toasting {
  static ToastificationItem simpleToast({
    required BuildContext context,
    required String message,
    int duration = 5,
    ToastificationType toastificationType = ToastificationType.info,
    ToastificationStyle toastificationStyle = ToastificationStyle.flatColored,
    Alignment alignment = Alignment.bottomCenter,
  }) {
    return toastification.show(
      context: context,
      title: Text(message),
      autoCloseDuration: Duration(seconds: duration),
      type: toastificationType,
      style: toastificationStyle,
      alignment: alignment,
      animationDuration: const Duration(seconds: 1),
      showProgressBar: false,
    );
  }
}
