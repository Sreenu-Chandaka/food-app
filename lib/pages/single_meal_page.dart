import 'package:flutter/material.dart';
import 'package:food_app/models/single_meal_model.dart';

import '../backend/random_single_meal_api.dart';
import '../backend/search_meal_api.dart';
import '../backend/single_meal_api.dart';

class SingleMealPage extends StatefulWidget {
  const SingleMealPage({super.key, required this.mealID});
  final String mealID;

  @override
  State<StatefulWidget> createState() {
    return _SingleMealPage();
  }
}

class _SingleMealPage extends State<SingleMealPage> {
  late Future<SingleMealResponse> futureData;
  late TextEditingController controller;
  @override
  void initState() {
    futureData = SingleMealApi.fetchSingleMeal(mealId: widget.mealID);
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: controller,
          decoration: InputDecoration(hintText: "Search Meal"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  futureData =
                      SearchMealApi.fetchSearchMeal(mealName: controller.text);
                });
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                setState(() {
                  futureData = RandomSingleMealApi.fetchRandomSingleMeal();
                });
              },
              icon: const Icon(Icons.radar)),
          IconButton(
              onPressed: () {
                setState(() {
                  futureData = RandomSingleMealApi.fetchRandomSingleMeal();
                });
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: FutureBuilder(
          future: futureData,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapShot.hasError) {
              const Text("Error fetching data... ");
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(snapShot.data!.meals!.first.strMeal!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                            height: 100,
                            width: 100,
                            snapShot.data!.meals!.first.strMealThumb!),
                      ],
                    ),
                    const Text(
                      "Ingredients:",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    Text(snapShot.data!.meals!.first.strIngredient1!),
                    Text(snapShot.data!.meals!.first.strIngredient2!),
                    Text(snapShot.data!.meals!.first.strIngredient3!),
                    Text(snapShot.data!.meals!.first.strIngredient4!),
                    Text(snapShot.data!.meals!.first.strIngredient5!),
                    const Text(
                      "Instructions:",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    Text(snapShot.data!.meals!.first.strInstructions!)
                  ],
                ),
              ),
            );
          }),
    );
  }
}
