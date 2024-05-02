import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';

Widget bigButton(String text, void Function()? onPressed, {bool isOutlined = false}) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          style: isOutlined ? ElevatedButton.styleFrom(
            backgroundColor: Colpal.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.brown, width: 3),
            ),
          ) : ElevatedButton.styleFrom(
            backgroundColor: Colpal.brown,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ), 
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isOutlined ? Colors.brown : Colors.white
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


Widget defaultBackButton(BuildContext context) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_rounded, weight: 300,),
    iconSize: 30,
    onPressed: () {
      Navigator.pop(context);
    },
  );
}