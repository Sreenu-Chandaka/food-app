import 'package:flutter/material.dart';
import 'package:food_app/backend/categories_api.dart';
import 'package:food_app/models/categories_model.dart';
import 'package:food_app/pages/meals_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late Future<CategoriesResponse> futureData;
  @override
  void initState() {
    futureData = CategoriesApi.fetchCategories();
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
            print(snapShot.data!.categories);
            print(
                "printing categories data in homepage...////////////////////////////////////");
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapShot.data!.categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DishPage(
                                      dishName: snapShot.data!.categories[index]
                                          .strCategory)));
                        },
                        child: Column(
                          children: [
                            Image.network(
                                height: 100,
                                width: 100,
                                snapShot
                                    .data!.categories[index].strCategoryThumb),
                            Text(snapShot.data!.categories[index].strCategory),
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
