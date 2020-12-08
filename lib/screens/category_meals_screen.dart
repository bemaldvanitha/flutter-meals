import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../data/dummy_data.dart';
import '../widget/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
    final catId = routeArgs['id'];
    final catTitle = routeArgs['title'];

    final filteredMeals = availableMeals.where((meal){
      return meal.categories.contains(catId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(catTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx,index){
            return MealItem(
              id: filteredMeals[index].id,
              title: filteredMeals[index].title,
              imageUrl: filteredMeals[index].imageUrl,
              duration: filteredMeals[index].duration,
              affordability: filteredMeals[index].affordability,
              complexity: filteredMeals[index].complexity,
            );
          },
        itemCount: filteredMeals.length,
      )
    );
  }
}
