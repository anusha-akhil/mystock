import 'dart:io';
import 'dart:typed_data';

import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../widgets/common_buttons.dart';
import '../constants.dart';
import 'select_photo_options_screen.dart';
import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class SetPhotoScreen extends StatefulWidget {
  const SetPhotoScreen({super.key});

  static const id = 'set_photo_screen';

  @override
  State<SetPhotoScreen> createState() => _SetPhotoScreenState();
}

class _SetPhotoScreenState extends State<SetPhotoScreen> {
  String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
// final picker = ImagePicker();
  File? _image;
//////////////////////////////////////////////////////////////
  captureAndSaveImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return null;

    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null)
        File(pickedImage.path).copy('${directory.path}/name.png');
    } catch (e) {
      return null;
    }
  }

////////////////////////////////////////////////////
  Future _pickImage(ImageSource source) async {
    String? tempFp;
    print("date----$date");

    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      // String path;
      Directory? extDir = await getExternalStorageDirectory();
      String dirPath = '${extDir!.path}/imageCropper/';

      imageCache.clearLiveImages();
      imageCache.clear();

      dirPath =
          dirPath.replaceAll("Android/data/com.example.mystock/files/", "");

      await Directory(dirPath).create(recursive: true);

      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      File copiedImage = await img!.copy('$dirPath/profile_picture.jpg');
      File newImage = File(copiedImage.path);

      // Uint8List bytes = await img.readAsBytes();
      // final resizedbytes =
      //     await resizeImage(Uint8List.view(bytes.buffer), height: 200);

      // if (resizedbytes != null) {
      //   final testing = Image.memory(Uint8List.view(bytes.buffer));
      //   // GallerySaver.saveImage(img.path,
      //   //     toDcim: true, albumName: 'image cropper');
      //   var result = await ImageGallerySaver.saveImage(
      //     Uint8List.view(resizedbytes.buffer),
      //     quality: 80,
      //     name: "new_mage.jpg",
      //   );

      // }

      print("img----$img");
      setState(() {
        _image = img;
        print("-image-------$_image");

        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

////////////////////////////////////////////////////
  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
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
    if (croppedImage == null) return null;

    print("cropped image path-----${croppedImage.path}");
    return File(croppedImage.path);
  }

////////////////////////////////////////////////////
  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: const [
                  //     SizedBox(
                  //       height: 30,
                  //     ),
                  //     Text(
                  //       'Set a photo of yourself',
                  //       style: kHeadTextStyle,
                  //     ),
                  //     SizedBox(
                  //       height: 8,
                  //     ),
                  //     Text(
                  //       'Photos make your profile more engaging',
                  //       style: kHeadSubtitleTextStyle,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: _image == null
                                ? const Text(
                                    'No image selected',
                                    style: TextStyle(fontSize: 20),
                                  )
                                : CircleAvatar(
                                    backgroundImage: FileImage(_image!),
                                    radius: 200.0,
                                  ),
                          )),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const Text(
                  //   'Anonymous',
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //     fontSize: 24,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
