import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSlide extends StatefulWidget {
  final List<String> images;
  final double height;
  final double width;

  const ImageSlide({super.key, required this.images, required this.height, required this.width});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {

  List<Widget> imageList = [];

  @override
  void initState() {
    for (String image in widget.images) {
      imageList.add(
        Image.network(
          image, 
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: SvgPicture.asset(
                "assets/icons/app_icon.svg",
                height: 50,
              ),
            );
          },
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ImageSlideshow(
        height: widget.height,
        width: widget.width,
        isLoop: false,
        indicatorColor: Colpal.white,
        indicatorPadding: 5,
        children: imageList,
      ),
    );
  }
}