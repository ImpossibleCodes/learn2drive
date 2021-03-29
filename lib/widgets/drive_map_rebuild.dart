import 'package:carp_background_location/carp_background_location.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:learn2drive/helpers/location_helper.dart';

class DriveMap extends StatefulWidget {
  LocationDto initialLocation;

  List<LatLng> points;
  Set<Polyline> polyline = {};
  GoogleMapController mapController;

  Function onMapCreated;

  DriveMap({
    @required this.initialLocation,
    @required this.points,
    @required this.polyline,
    @required this.mapController,
    @required this.onMapCreated,
  });

  @override
  _DriveMapState createState() => _DriveMapState();
}

class _DriveMapState extends State<DriveMap> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: widget.onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.initialLocation.latitude,
          widget.initialLocation.longitude,
        ),
        zoom: 20,
      ),
      polylines: widget.polyline,
    );
  }
}
