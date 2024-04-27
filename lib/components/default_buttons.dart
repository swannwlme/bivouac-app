import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget bigButton(String text, Color color, Color textColor, void Function()? onPressed, {bool isOutlined = false}) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          style: isOutlined ? ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: color, width: 3),
            ),
          ) : ElevatedButton.styleFrom(
            backgroundColor: color,
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
                color: textColor
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