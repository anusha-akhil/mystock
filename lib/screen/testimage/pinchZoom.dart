// // import 'package:flutter/material.dart';
// // import 'package:mystock/components/commonColor.dart';

// // class PinchZoomPageScreen extends StatefulWidget {
// //   const PinchZoomPageScreen({Key? key}) : super(key: key);

// //   @override
// //   State<PinchZoomPageScreen> createState() => _PinchZoomPageScreenState();
// // }

// // class _PinchZoomPageScreenState extends State<PinchZoomPageScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: P_Settings.loginPagetheme,
// //       body: Container(
// //         child: PinchZoomImage(),
// //       ),
// //     );
// //   }
// // }

// // /////////////////////////////////////////////////////////////

// // class PinchZoomImage extends StatefulWidget {
// //   const PinchZoomImage({Key? key}) : super(key: key);

// //   @override
// //   State<PinchZoomImage> createState() => _PinchZoomImageState();
// // }

// // class _PinchZoomImageState extends State<PinchZoomImage>
// //     with SingleTickerProviderStateMixin {
// //   final double minScale = 1;
// //   final double maxScale = 4;
// //   double scale=1;
// //   late TransformationController controller;
// //   late AnimationController animationController;
// //   Animation<Matrix4>? animation;
// //   OverlayEntry? entry;
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     controller = TransformationController();
// //     animationController =
// //         AnimationController(vsync: this, duration: Duration(microseconds: 300))
// //           ..addListener(() {
// //             controller.value = animation!.value;
// //           })..addStatusListener((status) {
// //             if(status==AnimationStatus.completed){
// //               removeOverlay();
// //             }
// //           });
// //   }

// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     controller.dispose();
// //     animationController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: InteractiveViewer(
// //         clipBehavior: Clip.none,
// //         maxScale: maxScale,
// //         minScale: minScale,
// //         panEnabled: false,
// //         transformationController: controller,
// //         onInteractionEnd: ((details) {
// //           resetAnimation();
// //         }),
// //         child: AspectRatio(
// //           aspectRatio: 1,
// //           child: ClipRRect(
// //             borderRadius: BorderRadius.circular(10),
// //             child: Image.network(
// //               "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/kitten-510651.jpg?h=f54c7448&itok=ZhplzyJ9",
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void resetAnimation() {
// //     animation = Matrix4Tween(begin: controller.value, end: Matrix4.identity())
// //         .animate(
// //             CurveTween(curve: Curves.easeOut).animate(animationController));
// //     animationController.forward(from: 0);
// //   }
// //   void removeOverlay(){
// //   entry!.remove();
// //   entry=null;
// //   }
// //   void showOverlay(BuildContext context) {
// //     final renderBox=context.findRenderObject()! as RenderBox;
// //     final offset=renderBox.localToGlobal(Offset.zero);
// //     final size=MediaQuery.of(context).size;
// //     entry = OverlayEntry(
// //       builder: (context) {
// //         final opacity=((scale - 1)/(maxScale-1)).clamp
// //         return Stack(
// //           children: [
// //             Positioned.fill(child: Opacity(
// //               opacity: opacity,
// //               child: Container(color: Colors.black,))),
// //             Positioned(
// //               left: offset.dx,
// //               right: offset.dy,
// //               width: size.width,
// //               child: buildImage()),
// //           ],
// //         );
// //       },
// //     );
// //     final overlay = Overlay.of(context)!;
// //     overlay.insert(entry!);
// //   }

// //   Widget buildImage() {
// //     return InteractiveViewer(
// //       clipBehavior: Clip.none,
// //       maxScale: maxScale,
// //       minScale: minScale,
// //       panEnabled: false,
// //       transformationController: controller,
// //       onInteractionStart: (details) {
// //         if (details.pointerCount < 2) return;
// //         showOverlay(context);
// //       },
// //       onInteractionEnd: (details) {
// //         resetAnimation();
// //       },
// //       onInteractionUpdate: (details) {
// //         if(entry==null ) return;
// //         this.scale=details.scale;
// //         entry!.markNeedsBuild();
// //       },
// //       child: AspectRatio(
// //         aspectRatio: 1,
// //         child: ClipRRect(
// //           borderRadius: BorderRadius.circular(10),
// //           child: Image.network(
// //             "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/kitten-510651.jpg?h=f54c7448&itok=ZhplzyJ9",
// //             fit: BoxFit.cover,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

// class PinchZoomEffectDemo extends StatefulWidget {
//   @override
//   _PinchZoomEffectDemoState createState() => _PinchZoomEffectDemoState();
// }

// class _PinchZoomEffectDemoState extends State<PinchZoomEffectDemo> {
//   double? _height;
//   double? _width;

//   PageController? pageController;

//   // @override
//   // void initState() {
//   //   pinchZoomModelList = Constants.getPinchZoomModelList();
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     _height = MediaQuery.of(context).size.height;
//     _width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[50],
//         title: Text(
//           'Pinch Zoom Effect',
//           style: TextStyle(color: Colors.black, fontSize: 18),
//         ),
//         centerTitle: true,
//         elevation: 1.0,
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.all(16.0),
//             // child: InteractiveViewer(
//             //   panEnabled: false, // Set it to false
//             //   boundaryMargin: EdgeInsets.all(100),
//             //   minScale: 0.5,
//             //   maxScale: 2,
//             //   child: Image.network(
//             //     'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/close-up-of-cat-wearing-sunglasses-while-sitting-royalty-free-image-1571755145.jpg',
//             //     width: 200,
//             //     height: 200,
//             //     fit: BoxFit.cover,
//             //   ),
//             // ),
//             child: PinchZoomReleaseUnzoomWidget(
//               child: Image.network(
//                 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/close-up-of-cat-wearing-sunglasses-while-sitting-royalty-free-image-1571755145.jpg',
//               ),
//               minScale: 0.8,
//               maxScale: 4,
//               resetDuration: const Duration(milliseconds: 200),
//               boundaryMargin: const EdgeInsets.only(bottom: 0),
//               clipBehavior: Clip.none,
//               useOverlay: true,
//               maxOverlayOpacity: 0.5,
//               overlayColor: Colors.black,
//               fingersRequiredToPinch: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
