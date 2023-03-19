import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math';

extension Shuffle on String {
  String get shuffled => (characters.toList()..shuffle()).join('');
}

Future<List> readJson(String filePath, String key) async {
  final String response = await rootBundle.loadString(filePath);
  final data = await json.decode(response);

  return data[key];
}

double heightScreen(BuildContext contextData, double percentHeight) {
  return MediaQuery.of(contextData).size.height * percentHeight;
}

double widthScreen(BuildContext contextData, double percentWidth) {
  return MediaQuery.of(contextData).size.width * percentWidth;
}

// Haversine formula
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const int radiusOfEarthInKm = 6371;

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) *
          cos(_degreesToRadians(lat2)) *
          sin(dLon / 2) *
          sin(dLon / 2);

  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = radiusOfEarthInKm * c;

  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
