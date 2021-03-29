import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

String coordinatesToString(List<LatLng> coordinates) {
  String coords = "";
  String approachesCurb = "?approaches=";
  coordinates.forEach(
    (element) {
      coords += (element.longitude.toString() +
          "," +
          element.latitude.toString() +
          ";");

      approachesCurb += "curb;";
    },
  );

  coords = coords.substring(0, coords.length - 1);
  approachesCurb = approachesCurb.substring(0, approachesCurb.length - 1);
  return coords + approachesCurb;
}

List<LatLng> coordsToLatLng(String coords) {
  List<LatLng> coordinates = [];
  List<String> coordinatesSplit = coords.split(";");
  List<List<String>> coordinatesSplitLngLat = [];
  coordinatesSplit.forEach(
    (element) {
      coordinatesSplitLngLat.add(element.split(","));
    },
  );
  coordinatesSplitLngLat.forEach(
    (element) {
      coordinates.add(
        LatLng(
          double.parse(element[1]),
          double.parse(element[0]),
        ),
      );
    },
  );
  return coordinates;
}

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

LatLng centerFromBounds(LatLngBounds bounds) {
  return LatLng((bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2);
}

double calculateDistance(LatLng p1, LatLng p2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((p2.latitude - p1.latitude) * p) / 2 +
      c(p1.latitude * p) *
          c(p2.latitude * p) *
          (1 - c((p2.longitude - p1.longitude) * p)) /
          2;
  return (12742 * asin(sqrt(a))) / 1.609344;
}
