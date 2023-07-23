import 'dart:io';

import 'package:amazon/models/product.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void Showsnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

Future<List<File>> pickImages() async {
  List<File> imageUrls = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        imageUrls.add(File(files.files[i].path!));
      }
      }
  } catch (e) {
    debugPrint(e.toString());
  }
  return imageUrls;
}
