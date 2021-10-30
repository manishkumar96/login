import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  final String image;

  final double imgHeight;
  final double imgWidth;

   const ImageComponent(
      {Key? key, required this.image, required this.imgHeight, required this.imgWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
          image,
          height: imgHeight,
          width: imgWidth,
          //height: Dimens().imageHeightForty,
          // width: Dimens().imageWidthForty,
        );
  }
}
