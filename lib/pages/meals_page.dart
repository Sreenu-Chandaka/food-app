import 'package:flutter/material.dart';
import 'package:food_app/backend/meals_api.dart';
import 'package:food_app/models/meals_model.dart';
import 'package:food_app/pages/single_meal_page.dart';

class DishPage extends StatefulWidget {
  const DishPage({super.key, required this.dishName});
  final String dishName;

  @override
  State<StatefulWidget> createState() {
    return _DishPageState();
  }
}

class _DishPageState extends State<DishPage> {
  late Future<DishResponse> futureData;
  @override
  void initState() {
    futureData = MealsApi.fetchDish(dishName: widget.dishName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: futureData,
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapShot.hasError) {
              const Text("Error fetching data... ");
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapShot.data!.meals.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SingleMealPage(
                                      mealID:
                                          snapShot.data!.meals[index].idMeal,
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            Image.network(
                                height: 100,
                                width: 100,
                                snapShot.data!.meals[index].strMealThumb),
                            Text(snapShot.data!.meals[index].strMeal),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
