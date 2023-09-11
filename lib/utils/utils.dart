import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();

  XFile? _file = await _imagepicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  log('No Image selected');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
