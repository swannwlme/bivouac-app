import 'dart:async';

import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/geo_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapScreen extends StatefulWidget {
  final List<dynamic> coordinates;
  const FullMapScreen({super.key, required this.coordinates});

  @override
  State<FullMapScreen> createState() => _FullMapScreenState();
}

class _FullMapScreenState extends State<FullMapScreen> {

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/svgs/camping_marker.svg")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapController.complete(controller);
            },

            markers: <Marker>{
              Marker(
                markerId: const MarkerId('location'),
                position: LatLng(widget.coordinates[0], widget.coordinates[1]),
                icon: markerIcon
              ),
            },

            initialCameraPosition: CameraPosition(
              target: LatLng(widget.coordinates[0], widget.coordinates[1]),
              zoom: 12,
            ),

            myLocationEnabled: true,

            myLocationButtonEnabled: false,
          ),

          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 49, left: 5),
              child: IconButton(
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
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 15, right: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colpal.brown,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            final String lat = widget.coordinates[0].toString();
                            final String lng = widget.coordinates[1].toString();
                            openGoogleMaps(lat, lng);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(17.0),
                            child: Text(
                              "Open in Maps",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    
                    IconButton(
                      onPressed: () async{
                        await determinePosition().then((value) {
                          mapController.future.then((controller) {
                            controller.animateCamera(CameraUpdate.newLatLng(LatLng(value.latitude, value.longitude)));
                          });
                        });
                      }, 
                      icon: const CircleAvatar(
                        backgroundColor: Colpal.brown,
                        radius: 30,
                        child: Icon(
                          Icons.my_location_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}