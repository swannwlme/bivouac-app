import 'package:bivouac/components/default_buttons.dart';
import 'package:bivouac/components/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SetLocationScreen extends StatefulWidget {
  const SetLocationScreen({super.key});

  @override
  State<SetLocationScreen> createState() => _SetLocationScreenState();
}

class _SetLocationScreenState extends State<SetLocationScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 10,
            ),

            myLocationButtonEnabled: false,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Column(
              children: [
                verticalSpacer(35),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  iconSize: 50,
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.black.withOpacity(0.8),
                    weight: 200,
                  )
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}