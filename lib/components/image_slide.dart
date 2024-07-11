import 'package:bivouac/components/mini_map.dart';
import 'package:bivouac/screens/full_image_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSlide extends StatefulWidget {
  final List<String> images;
  final double height;
  final double width;
  final bool showLocation;
  final List<dynamic>? coordinates;

  const ImageSlide({super.key, required this.images, required this.height, required this.width,this.showLocation = false, this.coordinates});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {

  List<Widget> imageList = [];
  int currentIndex = 0;

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
    return Material(
      elevation: 7,
      
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FullImageScreen(image: imageList[currentIndex],),));
            
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ImageSlideshow(
                height: widget.height,
                width: widget.width,
                isLoop: false,
                indicatorColor: Colpal.white,
                indicatorPadding: 5,
                children: imageList,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
              ),
            ),
          ),

          if (widget.showLocation && widget.coordinates!=null)
            Positioned(
              bottom: 7,
              right: 8,
              child: MiniMap(
                coordinates: widget.coordinates!, 
                height: 100, 
                width: 100,
                borderColor: Colpal.white,
                zoom: 10,
                showMarker: false,
              ),
            ),
        ],
      ),
    );
  }
}