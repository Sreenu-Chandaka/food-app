// To parse this JSON data, do
//
//     final dishResponse = dishResponseFromJson(jsonString);

import 'dart:convert';

DishResponse dishResponseFromJson(String str) =>
    DishResponse.fromJson(json.decode(str));

String dishResponseToJson(DishResponse data) => json.encode(data.toJson());

class DishResponse {
  final List<Meal> meals;

  DishResponse({
    required this.meals,
  });

  factory DishResponse.fromJson(Map<String, dynamic> json) => DishResponse(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
