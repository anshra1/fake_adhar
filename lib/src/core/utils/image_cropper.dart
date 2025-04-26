import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  factory ImageService() => instance;
  ImageService._internal();
  static final ImageService instance = ImageService._internal();

  /// Picks an image from the specified source and then crops it
  Future<File?> pickAndCropImage({
    required BuildContext context,
    required ImageSource source,
    int? maxWidth,
    int? maxHeight,
    double? aspectRatio,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    CropStyle cropStyle = CropStyle.rectangle,
    ImageCompressFormat compressFormat = ImageCompressFormat.jpg,
    int compressQuality = 90,
    ThemeData? themeData,
    Color? toolbarColor,
    Color? statusBarColor,
    Color? toolbarWidgetColor,
    String? toolbarTitle,
  }) async {
    try {
      final pickedFile = await _pickImage(source: source);
      if (pickedFile == null) {
        debugPrint('No image selected');
        return null;
      }

      if (!context.mounted) return null;

      return await cropImage(
        context: context,
        sourcePath: pickedFile.path,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        aspectRatio: aspectRatio,
        aspectRatioPresets: aspectRatioPresets,
        cropStyle: cropStyle,
        compressFormat: compressFormat,
        compressQuality: compressQuality,
        themeData: themeData,
        toolbarColor: toolbarColor,
        statusBarColor: statusBarColor,
        toolbarWidgetColor: toolbarWidgetColor,
        toolbarTitle: toolbarTitle,
      );
    } on Exception catch (e) {
      debugPrint('Error picking or cropping image: $e');
      return null;
    }
  }

  /// Picks an image using image_picker
  Future<XFile?> _pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    return picker.pickImage(source: source);
  }

  /// Crops an image at the specified path
  Future<File?> cropImage({
    required BuildContext context,
    required String sourcePath,
    int? maxWidth,
    int? maxHeight,
    double? aspectRatio,
    List<CropAspectRatioPreset>? aspectRatioPresets,
    CropStyle cropStyle = CropStyle.rectangle,
    ImageCompressFormat compressFormat = ImageCompressFormat.jpg,
    int compressQuality = 90,
    ThemeData? themeData,
    Color? toolbarColor,
    Color? statusBarColor,
    Color? toolbarWidgetColor,
    String? toolbarTitle,
  }) async {
    try {
      aspectRatioPresets ??= [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ];

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        aspectRatio:
            aspectRatio != null ? CropAspectRatio(ratioX: aspectRatio, ratioY: 1) : null,
        compressFormat: compressFormat,
        compressQuality: compressQuality,
        uiSettings: _buildUiSettings(
          context: context,
          aspectRatioPresets: aspectRatioPresets,
          cropStyle: cropStyle,
          themeData: themeData,
          toolbarColor: toolbarColor,
          statusBarColor: statusBarColor,
          toolbarWidgetColor: toolbarWidgetColor,
          toolbarTitle: toolbarTitle,
        ),
      );

      if (croppedFile == null) {
      
        return null;
      }

      return File(croppedFile.path);
    } on Exception {
   
      return null;
    }
  }

  /// Builds UI settings based on platform
  List<PlatformUiSettings> _buildUiSettings({
    required BuildContext context,
    required List<CropAspectRatioPreset> aspectRatioPresets,
    required CropStyle cropStyle,
    ThemeData? themeData,
    Color? toolbarColor,
    Color? statusBarColor,
    Color? toolbarWidgetColor,
    String? toolbarTitle,
  }) {
    final settings = <PlatformUiSettings>[
      AndroidUiSettings(
        toolbarTitle: toolbarTitle ?? 'Crop Image',
        toolbarColor: toolbarColor ?? Theme.of(context).primaryColor,
        statusBarColor: statusBarColor ?? Theme.of(context).primaryColorDark,
        toolbarWidgetColor: toolbarWidgetColor ?? Colors.white,
        backgroundColor: Colors.black,
        activeControlsWidgetColor: Theme.of(context).primaryColor,
        dimmedLayerColor: Colors.black.withOpacity(0.7),
        cropFrameColor: Colors.white,
        cropGridColor: Colors.white,
        cropFrameStrokeWidth: 2,
        cropGridRowCount: 3,
        cropGridColumnCount: 3,
        showCropGrid: true,
        lockAspectRatio: aspectRatioPresets.length == 1,
        initAspectRatio: aspectRatioPresets.first,
        aspectRatioPresets: aspectRatioPresets,
        hideBottomControls: false,
      ),
      IOSUiSettings(
        title: toolbarTitle ?? 'Crop Image',
        doneButtonTitle: 'Done',
        cancelButtonTitle: 'Cancel',
        hidesNavigationBar: false,
        aspectRatioPickerButtonHidden: aspectRatioPresets.length <= 1,
        aspectRatioLockEnabled: aspectRatioPresets.length == 1,
        aspectRatioPresets: aspectRatioPresets,
        rectX: 0,
        rectY: 0,
        rectWidth: 0,
        rectHeight: 0,
        showActivitySheetOnDone: false,
      ),
    ];

    if (kIsWeb) {
      settings.add(
        WebUiSettings(
          context: context,
          //  presentStyle: CropperPresentStyle.dialog,
          // boundary: const CroppieBoundary(
          //   width: 520,
          //   height: 520,
          // ),
          //   viewPort: const CroppieViewPort(
          //     width: 480,
          //     height: 480,
          //     type: 'circle',
          //   ),
          //   enableExif: true,
          //   enableZoom: true,
          //   showZoomer: true,
        ),
      );
    }

    return settings;
  }
}

// Custom aspect ratio preset
class CustomAspectRatioPreset implements CropAspectRatioPresetData {
  CustomAspectRatioPreset({
    required this.width,
    required this.height,
    required this.displayName,
  });

  final int width;
  final int height;
  final String displayName;

  @override
  (int, int)? get data => (width, height);

  @override
  String get name => displayName;
}
