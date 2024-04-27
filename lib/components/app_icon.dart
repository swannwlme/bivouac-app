import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget appIcon({double width = 50}) {
  return SvgPicture.asset("assets/icons/app_icon.svg", width: width, height: width,);
}