import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<XFile?> pickImage(
    ImageSource imageSource, {
    bool shouldCrop = true,
    required BuildContext context, required source,
  }) async {
    try {
      final XFile? photo = await _imagePicker.pickImage(source: imageSource);
      if (photo == null) return null;

      return photo;
    } catch (error) {
      if (kDebugMode) {
        print('Error picking image: $error');
      }
    }

    return null;
  }
}
