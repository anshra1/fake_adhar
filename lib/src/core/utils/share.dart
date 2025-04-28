import 'dart:io';
import 'dart:typed_data' show Uint8List;

import 'package:fake_adhar/src/core/utils/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareObject {
  static Future<void> shareImage({
    required BuildContext context,
    required Uint8List imageBytes,
    String shareFileName = 'shared_image.png',
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$shareFileName');
      await file.writeAsBytes(imageBytes);

      final shareResult = await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)]),
      );

      if (shareResult.status == ShareResultStatus.success) {
        if (context.mounted) {
          Toasting.simpleToast(context: context, message: 'Image shared successfully !');
        }
      } else {
        if (context.mounted) {
          Toasting.simpleToast(
            context: context,
            message: 'Image sharing canceled or failed.',
          );
        }
      }

      // Close dialog
    } on Exception catch (e) {
      if (context.mounted) {
        Toasting.simpleToast(context: context, message: 'Share failed: $e');
      }

      debugPrint('Shared failed $e');
    }
  }
}
