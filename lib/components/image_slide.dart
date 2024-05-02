import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

Widget imageSlide(List<Widget> images, double height, double width){

  return Material(
    elevation: 8,
    borderRadius: BorderRadius.circular(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ImageSlideshow(
        height: height,
        width: width,
        isLoop: false,
        indicatorColor: Colpal.white,
        indicatorPadding: 5,
      
        children: images,
      ),
    ),
  );
}