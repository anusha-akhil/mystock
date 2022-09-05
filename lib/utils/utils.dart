// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class Utils {
//   static Future<File> pickMedia(
//       {required bool isGallery,
//       required Future<File> Function(File file) cropImage}) async {
//     final source = isGallery ? ImageSource.gallery : ImageSource.camera;
//     final pickedFile = await ImagePicker().pickImage(source: source);

//     // if (pickedFile == null) {
//     //   return null;
//     // }
//     if(cropImage==null){
//       return File(pickedFile!.path);
//     }else{
//       final file=File(pickedFile!.path);
//       return cropImage(file);
//     }
//   }
// }

import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  // Utils._();

  /// Open image gallery and pick an image
  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  /// Pick Image From Gallery and return a File
  Future<CroppedFile?> cropSelectedImage(String filePath) async {
    print("filennn-----$filePath");
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    // return await ImageCropper.cropImage(
    //   sourcePath: filePath,
    //   aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),

    // );
    print("croppedImage-----$croppedImage");
    return croppedImage;
  }
}
