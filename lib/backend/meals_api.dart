import 'dart:convert';

import '../models/meals_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MealsApi {
  static Future<DishResponse> fetchDish({required String dishName}) async {
    final response = await http.get(Uri.parse(
        "https://www.themealdb.com/api/json/v1/1/filter.php?c=$dishName"));

    debugPrint("printing response${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DishResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
