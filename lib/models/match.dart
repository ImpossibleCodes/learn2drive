import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:learn2drive/helpers/location_helper.dart';

Future<Match> fetchMatch(List<LatLng> coordinates) async {
  String requestURL = "https://api.mapbox.com/matching/v5/mapbox/driving/";
  String parameters =
      "&geometries=geojson&tidy=true&access_token=pk.eyJ1IjoiMjAyM25hZ3Jhd2FsIiwiYSI6ImNrajd3bHBucTFrYnMyc3A2YXk3a3B3MTgifQ.JRHKzQmSp0Y8mbpyhWMpuw";

  requestURL += coordinatesToString(coordinates) + parameters;
  final response = await http.get(requestURL);

  if (response.statusCode == 200 &&
      json.decode(response.body)['code'] as String == "Ok") {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(requestURL);
    return Match.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print(response.body);
    print(requestURL);
    throw Exception('Failed to load match');
  }
}

class Match {
  double duration;
  double distance;
  List<LatLng> coordinates; //.fromJson();

  Match(this.duration, this.distance, this.coordinates);

  factory Match.fromJson(Map<String, dynamic> json) {
    double duration = ((json['matchings'] as List<dynamic>)[0]
        as Map<String, dynamic>)['duration'] as double;
    double distance = ((json['matchings'] as List<dynamic>)[0]
        as Map<String, dynamic>)['distance'] as double;
    List<dynamic> coordinatesAsDynamic = (((json['matchings']
            as List<dynamic>)[0] as Map<String, dynamic>)['geometry']
        as Map<String, dynamic>)['coordinates'] as List<dynamic>;
    List<List<double>> coordinatesAsDouble = [];
    coordinatesAsDynamic.forEach(
      (element) {
        coordinatesAsDouble.add(
          [
            (element as List<dynamic>)[0] as double,
            (element as List<dynamic>)[1] as double,
          ],
        );
      },
    );
    List<LatLng> coordinates =
        coordinatesAsDouble.map((pair) => LatLng(pair[1], pair[0])).toList();

    return Match(duration, distance, coordinates);
  }
}
