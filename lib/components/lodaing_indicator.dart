import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';

Widget loadingIndicator(bool isLoading) {
  if(!isLoading) return Container();
  
  return const Center(
    child: CircularProgressIndicator(
      color: Colpal.grey,
    ),
  );
}