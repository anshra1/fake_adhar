import 'dart:io';

import 'package:baby_package/baby_package.dart';
import 'package:fake_adhar/src/core/utils/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends HookWidget {
  const ImagePickerWidget({
    required this.onImageSelected,
    this.text,
    super.key,
  });

  final ValueNotifier<File?> onImageSelected;
  final String? text;


  @override
  Widget build(BuildContext context) {
    final selectedImage = useState<File?>(onImageSelected.value);

    Future<void> pickAndCropImage() async {
      final imageService = ImageService.instance;
      final imageFile = await imageService.pickAndCropImage(
        context: context,
        source: ImageSource.gallery,
        aspectRatio: 325 / 408,
        aspectRatioPresets: [CropAspectRatioPreset.original],
        toolbarTitle: 'Crop headshot of the face',
      );

      if (imageFile != null) {
        selectedImage.value = imageFile;
        onImageSelected.value = selectedImage.value;
      }
    }

    return CustomFormField<String?>(
      initialValue: 'Pick an image',
      validator: (value) {
        if (value! == 'Pick an image') {
          return 'You do not select the image';
        }
        return null;
      },
      widget: (
        BuildContext context,
        String? currentValue,
        void Function(String?) onChanged,
        String? errorText,
      ) {
        return AspectRatio(
          aspectRatio: 325 / 408,
          child: ConditionalWidget(
            condition: selectedImage.value == null,
            widget: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: errorText == null ? Colors.grey[200]! : Colors.red,
                  width: errorText == null ? 1 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image,
                    size: 48,
                    color: errorText == null ? Colors.grey[600] : Colors.red,
                  ), // Picker icon
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () async {
                      await pickAndCropImage().then((value) {
                        if (selectedImage.value != null) {
                          onChanged('Image is selcted');
                        }
                      });
                    },
                    child: Text(
                      errorText ?? currentValue ?? 'I am a image',
                      style: TextStyle(
                        fontSize: 16,
                        color: errorText == null ? Colors.grey[600] : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            fallback: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!),
                    image: selectedImage.value != null
                        ? DecorationImage(
                            image: FileImage(selectedImage.value!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ), // Change icon
                      onPressed: pickAndCropImage,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // child: Stack(
          //   children: [

          //     ConditionalWidget(
          //       condition: selectedImage.value != null,
          //       widget:
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
