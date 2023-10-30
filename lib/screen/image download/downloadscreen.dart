// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class DownloadScreen extends StatefulWidget {
//   const DownloadScreen({Key? key}) : super(key: key);

//   @override
//   State<DownloadScreen> createState() => _DownloadScreenState();
// }

// class _DownloadScreenState extends State<DownloadScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         // mainAxisAlignment: MA,
//         children: [
//           Container(
//               height: 400,
//               width: 400,
//               child: Image.network(
//                   "https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?cs=srgb&dl=pexels-pixabay-56866.jpg&fm=jpg")),
//           ElevatedButton(
//               onPressed: () async{
//                 String url =
//                     "https://images.pexels.com/photos/56866/garden-rose-red-pink-56866.jpeg?cs=srgb&dl=pexels-pixabay-56866.jpg&fm=jpg";
//                 final tempDir=await getTemporaryDirectory();
//                 final path='${tempDir.path}/myfile.jpg';
//                 await Dio().download(url,path);
//                 GallerySaver.saveImage(url,toDcim: true,albumName: 'flutter');
//               },
//               child: Text("download"))
//         ],
//       ),
//     );
//   }
// }
