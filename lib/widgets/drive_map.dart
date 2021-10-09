import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carp_background_location/carp_background_location.dart';

enum LocationStatus {
  UNKNOWN,
  RUNNING,
  STOPPED,
}

String dtoToString(LocationDto dto) =>
    'Location ${dto.latitude}, ${dto.longitude} at ${DateTime.fromMillisecondsSinceEpoch(dto.time ~/ 1)}';

class DriveMap extends StatefulWidget {
  @override
  _DriveMapState createState() => _DriveMapState();
}

class _DriveMapState extends State<DriveMap> {
  final points = [
    LatLng(32.712036, -117.172834),
    LatLng(32.712246, -117.172908),
    LatLng(32.71244, -117.17292),
    LatLng(32.71256, -117.172922),
    LatLng(32.712599, -117.172922),
    LatLng(32.7126, -117.17298),
    LatLng(32.712597, -117.17314),
    LatLng(32.712546, -117.173344),
  ];
  //final LatLng _center = const LatLng(38.936839, -77.413242);
  Set<Polyline> polyline = {};

  String logStr = '';
  LocationDto lastLocation;
  DateTime lastTimeLocation;
  LocationManager locationManager = LocationManager.instance;
  Stream<LocationDto> dtoStream;
  StreamSubscription<LocationDto> dtoSubscription;
  LocationStatus _status = LocationStatus.UNKNOWN;
  GoogleMapController mapController;

  LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1 + 0.001, y1 + 0.001),
      southwest: LatLng(x0 - 0.001, y0 - 0.001),
    );
  }

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
        width: 4,
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
    locationManager.interval = 1;
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
    print(dtoToString(dto));
    setState(() {
      if (_status == LocationStatus.UNKNOWN) {
        _status = LocationStatus.RUNNING;
      }
      lastLocation = dto;
      lastTimeLocation = DateTime.now();
    });
  }

  void start() async {
    // Subscribe if it hasn't been done already
    if (dtoSubscription != null) {
      dtoSubscription.cancel();
    }
    dtoSubscription = dtoStream.listen(onData);
    await locationManager.start();
    setState(() {
      _status = LocationStatus.RUNNING;
    });
  }

  void stop() async {
    setState(() {
      _status = LocationStatus.STOPPED;
    });
    dtoSubscription.cancel();
    await locationManager.stop();
  }

  Widget stopButton() {
    Function f = stop;
    String msg = 'STOP';

    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text(msg),
        onPressed: f,
      ),
    );
  }

  Widget startButton() {
    Function f = start;
    String msg = 'START';
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text(msg),
        onPressed: f,
      ),
    );
  }

  Widget status() {
    String msg = _status.toString().split('.').last;
    return Text("Status: $msg");
  }

  Widget lastLoc() {
    return Text(
        lastLocation != null
            ? dtoToString(lastLocation)
            : 'Unknown last location',
        textAlign: TextAlign.center);
  }

  Widget getButton() {
    return ElevatedButton(
      child: Text("Get Current Location"),
      onPressed: onGetCurrentLocation,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: double.maxFinite,
    //   padding: const EdgeInsets.all(22),
    //   child: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         Divider(),
    //         status(),
    //         Divider(),
    //         dtoWidget(lastLocation),
    //         getButton(),
    //         startButton(),
    //         stopButton(),
    //       ],
    //     ),
    //   ),
    // );
    start();

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(lastLocation.latitude, lastLocation.longitude),
        zoom: 17,
      ),
      polylines: polyline,
    );
  }
}
