import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/single_meal_model.dart';

class RandomSingleMealApi {
  static Future<SingleMealResponse> fetchRandomSingleMeal() async {
    final response = await http
        .get(Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php"));

    debugPrint("printing response${response.body}");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return SingleMealResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
