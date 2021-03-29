import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carp_background_location/carp_background_location.dart';

import 'package:learn2drive/helpers/location_helper.dart';
import 'package:learn2drive/models/match.dart';

class DriveMap extends StatefulWidget {
  @override
  _DriveMapState createState() => _DriveMapState();
}

class _DriveMapState extends State<DriveMap> {
  List<LatLng> points;
  Set<Polyline> polyline = {};
  LocationDto lastLocation;
  DateTime lastTimeLocation;
  LocationManager locationManager = LocationManager.instance;
  Stream<LocationDto> dtoStream;
  StreamSubscription<LocationDto> dtoSubscription;
  GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          boundsFromLatLngList(points),
          1,
        ),
      );
    });
    polyline.add(
      Polyline(
        polylineId: PolylineId('currentDrive'),
        visible: true,
        points: points,
        width: 6,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Subscribe to stream in case it is already running
    locationManager.interval = 5;
    locationManager.distanceFilter = 0;
    locationManager.notificationTitle = 'Learn2Drive is tracking your drive';
    locationManager.notificationMsg = 'Learn2Drive is tracking your drive';
    dtoStream = locationManager.dtoStream;
    dtoSubscription = dtoStream.listen(onData);
  }

  void onGetCurrentLocation() async {
    LocationDto dto = await locationManager.getCurrentLocation();

    print('Current location: $dto');
  }

  void onData(LocationDto dto) {
    setState(
      () {
        lastLocation = dto;
        lastTimeLocation = DateTime.now();
      },
    );
  }

  void start() async {
    Match match = await fetchMatch(coordsToLatLng(
        "-117.17282,32.71204;-117.17288,32.71225;-117.17293,32.71244;-117.17292,32.71256;-117.17298,32.712603;-117.17314,32.71259;-117.17334,32.71254"));

    points = match.coordinates;
    // Subscribe if it hasn't been done already
    if (dtoSubscription != null) {
      dtoSubscription.cancel();
    }
    dtoSubscription = dtoStream.listen(onData);
    await locationManager.start();
  }

  void stop() async {
    dtoSubscription.cancel();
    await locationManager.stop();
  }

  @override
  Widget build(BuildContext context) {
    if (points == null) start();
    return lastLocation == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(lastLocation.latitude, lastLocation.longitude),
              zoom: 15,
            ),
            polylines: polyline,
          );
  }
}
