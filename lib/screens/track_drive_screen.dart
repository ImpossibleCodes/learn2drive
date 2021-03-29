import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carp_background_location/carp_background_location.dart';

import 'package:learn2drive/helpers/location_helper.dart';
import 'package:learn2drive/models/match.dart';
import 'package:learn2drive/widgets/default_app_bar.dart';
import 'package:learn2drive/widgets/drive_map_rebuild.dart';
import 'package:learn2drive/widgets/drive_tracker_info.dart';
//import 'package:learn2drive/widgets/drive_map_test.dart';
//import 'package:learn2drive/widgets/drive_map.dart';

class TrackDriveScreen extends StatefulWidget {
  @override
  _TrackDriveScreenState createState() => _TrackDriveScreenState();
}

class _TrackDriveScreenState extends State<TrackDriveScreen> {
  bool _tracking = false;

  LocationManager _locationManager = LocationManager.instance;
  List<LatLng> _points = [];
  Set<Polyline> _polyline = {};
  LatLng _currentLocation;
  DateTime _startTime;

  double _distance = 0.0;
  int _duration = 0;

  Stream<LocationDto> _dtoStream;
  StreamSubscription<LocationDto> _dtoSubscription;
  GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    // Subscribe to stream in case it is already running
    _locationManager.interval = 3;
    _locationManager.distanceFilter = 0;
    _locationManager.accuracy = LocationAccuracy.HIGH;
    _locationManager.notificationTitle = 'Learn2Drive is tracking your drive';
    _locationManager.notificationMsg = 'Learn2Drive is tracking your drive';
    _dtoStream = _locationManager.dtoStream;
    _dtoSubscription = _dtoStream.listen(_onData);
  }

  void _start() async {
    // Match match = await fetchMatch(coordsToLatLng(
    //     "-117.17282,32.71204;-117.17288,32.71225;-117.17293,32.71244;-117.17292,32.71256;-117.17298,32.712603;-117.17314,32.71259;-117.17334,32.71254"));

    // points = match.coordinates;

    setState(
      () {
        _tracking = true;
        _startTime = DateTime.now();
      },
    );
    print("reached point");
    // Subscribe if it hasn't been done already
    if (_dtoSubscription != null) {
      _dtoSubscription.cancel();
    }
    _dtoSubscription = _dtoStream.listen(_onData);
    await _locationManager.start();
  }

  void _stop() async {
    setState(
      () {
        _tracking = false;
      },
    );

    _dtoSubscription.cancel();
    await _locationManager.stop();
  }

  void _onData(LocationDto dto) {
    setState(
      () {
        _currentLocation = LatLng(dto.latitude, dto.longitude);

        CameraPosition cPosition = CameraPosition(
          zoom: 20,
          tilt: 60,
          bearing: dto.heading,
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
        );

        _points.add(_currentLocation);

        _controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

        print("added location");

        _duration = DateTime.now().difference(_startTime).inMinutes;
        _distance +=
            calculateDistance(_currentLocation, _points[_points.length - 1]);
      },
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;

    _polyline.add(
      Polyline(
        polylineId: PolylineId('currentDrive'),
        visible: true,
        points: _points,
        width: 6,
        color: Colors.blue,
        startCap: Cap.roundCap,
        endCap: Cap.buttCap,
      ),
    );

    print("Map Created");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _locationManager.getCurrentLocation(),
      builder: (context, snapshot) {
        LocationDto locationDto = snapshot.data;
        return Scaffold(
          appBar: DefaultAppBar(context),
          body: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: snapshot.hasData
                    ? StreamBuilder<Object>(
                        stream: null,
                        builder: (context, snapshot) {
                          return GoogleMap(
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            buildingsEnabled: false,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            compassEnabled: true,
                            tiltGesturesEnabled: false,
                            polylines: _polyline,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                locationDto.latitude,
                                locationDto.longitude,
                              ),
                              zoom: 20,
                              tilt: 60,
                              bearing: locationDto.heading,
                            ),
                            onMapCreated: _onMapCreated,
                          );
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      if (_tracking) DriveTrackerInfo(_duration, _distance),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon:
                              Icon(!_tracking ? Icons.play_arrow : Icons.stop),
                          onPressed: !_tracking ? _start : _stop,
                        ),
                      ),
                      if (_tracking && _points.isNotEmpty)
                        Text(_points[_points.length - 1].latitude.toString() +
                            ", " +
                            _points[_points.length - 1].longitude.toString())
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
