import 'package:bivouac/components/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget appIcon({double width = 50, bool elevated=true}) {
  return Column(
    children: [
      SvgPicture.asset("assets/icons/app_icon.svg", width: width, height: width,),
      elevated ? verticalSpacer(5) : Container()
    ],
  );
}