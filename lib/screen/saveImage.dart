import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mystock/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;
  Utils utils = Utils();
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text(
                            "PICK FROM GALLERY",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  )));
  }

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    _cropImage(pickedFile!.path);
  }

  /// Crop Image
  _cropImage(filePath) async {
    // final croppedImage = await ImageCropper().cropImage(
    //   sourcePath: filePath,
    //   aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    // );
    File croppedImage = (await ImageCropper().cropImage(
      sourcePath: filePath,
      maxWidth: 1080,
      maxHeight: 1080,
    )) as File;
    if (croppedImage != null) {
      imageFile = croppedImage;
      setState(() {});
    }
  }
}
