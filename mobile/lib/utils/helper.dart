import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
