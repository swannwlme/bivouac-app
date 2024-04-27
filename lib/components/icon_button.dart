import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


Widget svgIconButton(String path, Function()? onPressed, {double size = 30}) {
  return IconButton(
    icon: CircleAvatar(
      backgroundColor: Colpal.lightGrey,
      radius: size/2 + 15,
      child: SvgPicture.asset(
        path,
        height: size,
      ),
    ),
    onPressed: onPressed,
  );
}