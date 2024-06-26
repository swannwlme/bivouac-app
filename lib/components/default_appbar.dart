import 'package:bivouac/components/app_icon.dart';
import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:flutter/material.dart';

AppBar defaultAppBar(context, {bool showBackButton = false, List<Widget>? actions}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          appIcon(width: 40),
          horizontalSpacer(10),
          const Text(
            "Bivouac",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions!=null ? Container() : showBackButton ? horizontalSpacer(95) : horizontalSpacer(38)
        ],
      ),
    ),

    actions: actions,

    leading: showBackButton ? defaultBackButton(context) : null,
  );
}