// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/utils/flutter_toast.dart';
import 'package:fake_adhar/src/core/utils/permission_shell.dart';
import 'package:fake_adhar/src/core/utils/share.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/cubit/document_cubit.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/widgets/adhaar_front_cover.dart';
import 'package:fake_adhar/src/features/dashboard/presentation/widgets/adharr_back_cover.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:screenshot/screenshot.dart';
import 'package:translator/translator.dart';

class AdhaarBuildPageView extends StatefulWidget {
  const AdhaarBuildPageView({required this.state, super.key});

  final DocumentState state;

  @override
  State<AdhaarBuildPageView> createState() => _AdhaarBuildPageViewState();
}

class _AdhaarBuildPageViewState extends State<AdhaarBuildPageView> {
  final ScreenshotController _frontCoverController = ScreenshotController();
  final ScreenshotController _backCoverController = ScreenshotController();

  Future<Uint8List?> _captureWidget(ScreenshotController controller) async {
    try {
      return await controller.capture();
    } on Exception catch (e) {
      debugPrint('Capture error: $e');
      return null;
    }
  }

  void _showPreviewDialog(BuildContext context, Uint8List imageBytes) {
    showDialog<void>(
      context: context,
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.pop(context); // This will close the dialog when tapped outside
        },
        behavior:
            HitTestBehavior.opaque, // Makes sure taps pass through to the GestureDetector
        child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.memory(
                  imageBytes,
                  fit: BoxFit.fill,
                  //  width: double.infinity,
                ),
                const Gap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppButton(
                          size: ButtonSize.large,
                          shape: ButtonShape.stadium,
                          onPressed: () {
                            saveToDevice(context, imageBytes).then((v) {
                              Navigator.pop(context);
                            });
                          },
                          text: 'Save to Device',
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: AppButton(
                          size: ButtonSize.large,
                          shape: ButtonShape.stadium,
                          onPressed: () async {
                            await ShareObject.shareImage(
                              context: context,
                              imageBytes: imageBytes,
                            );
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          text: 'Share',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveToDevice(BuildContext context, Uint8List imageBytes) async {
    try {
      await PermissionShell().saveFile(
        androidLogic: () async {
          final savePath = await FilePicker.platform.saveFile(
            fileName: 'image_${DateTime.now().millisecondsSinceEpoch}.png',
            bytes: imageBytes,
          );

          if (savePath == null) {
            if (!mounted) return;
            Toasting.simpleToast(context: context, message: 'Save canceled.');
            return;
          }

          if (!mounted) return;
          Toasting.simpleToast(context: context, message: 'Image Saved');
          return Future.value();
        },
        iosLogic: () {
          return Future.value();
        },
      );
    } on Exception catch (e) {
      if (!mounted) return;
      print('Error saving image: $e');
      Toasting.simpleToast(context: context, message: 'Error saving image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight / 2.9;
        final fontSize = height * 0.025;

        return SingleChildScrollView(
          child: Column(
            spacing: 24,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(16),
              Screenshot(
                controller: _frontCoverController,
                child: FrontCoverWidget(
                  width: width,
                  height: height,
                  fontSize: fontSize,
                  state: widget.state,
                  imagePath: 'asset/images/front.png',
                ),
              ),
              if (widget.state.backCover?.fatherName != null)
                Screenshot(
                  controller: _backCoverController,
                  child: BackCoverWidget(
                    width: width,
                    height: height,
                    fontSize: fontSize,
                    state: widget.state,
                    imagePath: 'asset/images/back.png',
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Save Front Cover',
                    onPressed: () async {
                      final imageBytes = await _captureWidget(_frontCoverController);
                      if (imageBytes != null) {
                        _showPreviewDialog(context, imageBytes);
                      }
                    },
                  ),
                  const Gap(16),
                  if (widget.state.backCover?.fatherName != null)
                    AppButton(
                      text: 'Save Back Cover',
                      onPressed: () async {
                        final imageBytes = await _captureWidget(_backCoverController);
                        if (imageBytes != null) {
                          _showPreviewDialog(context, imageBytes);
                        }
                      },
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
