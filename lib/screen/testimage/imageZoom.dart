import 'package:flutter/material.dart';
import 'package:mystock/components/commonColor.dart';

class Imagezoom extends StatefulWidget {
  const Imagezoom({Key? key}) : super(key: key);

  @override
  State<Imagezoom> createState() => _ImagezoomState();
}

class _ImagezoomState extends State<Imagezoom>
    with SingleTickerProviderStateMixin {
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  TapDownDetails? tapDownDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TransformationController();
    animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: 300))
          ..addListener(() {
            controller.value = animation!.value;
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: P_Settings.loginPagetheme,
      body: Container(
        alignment: Alignment.center,
        child: buildImage(),
      ),
    );
  }

  Widget buildImage() {
    return GestureDetector(
      onTapDown: (details) => tapDownDetails = details,
      onTap: () {
        final position = tapDownDetails!.localPosition;
        final double scale = 3;
        final x = -position.dx * (scale - 1);
        final y = -position.dy * (scale - 1);

        final zoomed = Matrix4.identity()
          ..translate(x, y)
          ..scale(scale);

        final end = controller.value.isIdentity() ? zoomed : Matrix4.identity();
        animation = Matrix4Tween(begin: controller.value, end: end).animate(
            CurveTween(curve: Curves.easeOut).animate(animationController));

        animationController.forward(from: 0);
      },
      child: InteractiveViewer(
        clipBehavior: Clip.none,
        transformationController: controller,
        panEnabled: false,
        scaleEnabled: false,
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            "https://www.humanesociety.org/sites/default/files/styles/1240x698/public/2020-07/kitten-510651.jpg?h=f54c7448&itok=ZhplzyJ9",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
