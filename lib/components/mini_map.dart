import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiniMap extends StatefulWidget {
  final List<dynamic> coordinates;
  final double height;
  final double width;
  final bool canMove;
  final double zoom;
  const MiniMap({super.key, required this.coordinates, required this.height, required this.width, this.canMove=false, this.zoom=11});

  @override
  State<MiniMap> createState() => _MiniMapState();
}

class _MiniMapState extends State<MiniMap> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height.toDouble(),
      width: widget.width.toDouble(),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colpal.brown,
          width: 1.5,
        ),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.coordinates[0], widget.coordinates[1]), // San Francisco coordinates
            zoom: widget.zoom,
          ),

          markers: {
            Marker(
              markerId: const MarkerId('Location'),
              position: LatLng(widget.coordinates[0], widget.coordinates[1]),
            ),
          },

          zoomGesturesEnabled: widget.canMove,
          scrollGesturesEnabled: widget.canMove,
          rotateGesturesEnabled: widget.canMove,
          tiltGesturesEnabled: widget.canMove,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}