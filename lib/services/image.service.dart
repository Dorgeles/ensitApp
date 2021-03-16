// creation de service qui compresse et redimensionne les images

import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File> compressImage(File file) async {
  final filePath = file.absolute.path;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

  final compressedImage = await FlutterImageCompress.compressAndGetFile(
      filePath, outPath,
      format: CompressFormat.jpeg, minWidth: 600, minHeight: 600, quality: 60);
  return compressedImage;
}
