import 'dart:io';
import 'dart:typed_data';

import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:image_picker/image_picker.dart';

class HomeImage extends StatefulWidget {
  @override
  State<HomeImage> createState() => _HomeImageState();
}

class _HomeImageState extends State<HomeImage> {
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  late File imagefile;

  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        imagefile = File(imagepath);
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  cropImage() async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imagepath,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1.0),
      // maxHeight: 100,
      // maxWidth: 100,
      // compressFormat: ,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      // uiSettings: [
      //   AndroidUiSettings(
      //       toolbarTitle: 'Cropper',
      //       toolbarColor: Colors.deepOrange,
      //       toolbarWidgetColor: Colors.white,
      //       initAspectRatio: CropAspectRatioPreset.original,
      //       lockAspectRatio: true),
      // ],
    );

    if (croppedImage != null) {
      imagefile = File(croppedImage.path);
      Uint8List bytes = await imagefile.readAsBytes();
      var result = await ImageGallerySaver.saveImage(
        bytes,
        quality: 60,
        name: "new_mage.jpg",
      );
      print(result);
      if (result["isSuccess"] == true) {
        print("Image saved successfully.");
      } else {
        print(result["errorMessage"]);
      }
      setState(() {});
    } else {
      print("Image is not cropped.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Open Image, Crop and Save"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30),
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              imagepath != ""
                  ? Container(height: 200, child: Image.file(imagefile))
                  : Container(
                      child: Text("No Image selected."),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //open button ----------------
                  ElevatedButton(
                      onPressed: () {
                        openImage();
                      },
                      child: Text("Open Image")),

                  //crop button --------------------
                  imagepath != ""
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent),
                          onPressed: () {
                            cropImage();
                          },
                          child: Text("Crop Image"))
                      : Container(),
                  ElevatedButton(
                      onPressed: () async {
                        if (imagefile != null) {
                          final rawImage = await imagefile.readAsBytes();
                          final bytes = await resizeImage(
                              Uint8List.view(rawImage.buffer),
                              height: 250);

                          //  Uint8List bytesw = await imagefile.readAsBytes();

                              print("jkzdfj-----${bytes.runtimeType}---------${rawImage.runtimeType}-----");

                          if (bytes != null) {
                            final testing =
                                Image.memory(Uint8List.view(bytes.buffer));

                             var result = await ImageGallerySaver.saveImage(
                              Uint8List.view(bytes.buffer),
                              quality: 60,
                              name: "new_mage.jpg",
                            );
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return AlertDialog(
                            //         title: Text("Image"),
                            //         content: testing,
                            //       );
                            //     });
                          }
                        }
                        // openImage();
                      },
                      child: Text("Resize Image")),
                  //save button -------------------
                  // imagepath != ""
                  //     ? ElevatedButton(
                  //         onPressed: () async {
                  //           Uint8List bytes = await imagefile.readAsBytes();
                  //           var result = await ImageGallerySaver.saveImage(
                  //             bytes,
                  //             quality: 60,
                  //             name: "new_mage.jpg",
                  //           );
                  //           print(result);
                  //           if (result["isSuccess"] == true) {
                  //             print("Image saved successfully.");
                  //           } else {
                  //             print(result["errorMessage"]);
                  //           }
                  //         },
                  //         child: Text("Save Image"))
                  //     : Container(),
                ],
              )
            ],
          ),
        ));
  }
}
