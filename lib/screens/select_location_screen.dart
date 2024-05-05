import 'dart:async';

import 'package:bivouac/components/spacers.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:bivouac/utils/geo_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectLocationScreen extends StatefulWidget {
  void Function(String, List) updateScreen;
  SelectLocationScreen({super.key, required this.updateScreen});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();
  List<double> tmpLocation = [0, 0];

  @override
  void initState() {
    determinePosition().then((value) {
      tmpLocation = [value.latitude, value.longitude];
      mapController.future.then((controller) {
        controller.animateCamera(
          CameraUpdate.newLatLng(LatLng(value.latitude, value.longitude))
        );
      });
    });
    super.initState();
  }

  void _onTap(LatLng position) {
    mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newLatLng(position)
      );
    });
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

            onTap: _onTap,

            onCameraMove: (position) {
              tmpLocation = [position.target.latitude, position.target.longitude];
            
            },

            initialCameraPosition: const CameraPosition(
              target: LatLng(37.7749, -122.4194),
              zoom: 12,
            ),

            myLocationEnabled: true,

            myLocationButtonEnabled: false,
          ),

          Container(
            height: 120.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white.withOpacity(0.85), Colors.white.withOpacity(0.75), Colors.white.withOpacity(0)],
              ),
            ),
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

          const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'Set Location',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          ),

          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Icon(
                Icons.location_on_rounded,
                color: Colpal.brown,
                size: 50,
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
                          mapController.future.then((controller) async{
                            await getAddressFromLocation(tmpLocation[0], tmpLocation[1]).then((value) {
                              
                              widget.updateScreen(value, [tmpLocation[0], tmpLocation[1]]);
                            });
                          });
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Text(
                            "Set Location",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),

                    horizontalSpacer(5),

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
                    )
                  ],
                )
              ),
            ),
          ),
        ],
      )
    );
  }
}