import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/meal_detail.dart';
import './screens/tabs_screen.dart';
import './screens/filters_scree.dart';

import './data/dummy_data.dart';
import './models/meal.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters ={
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _favoriteMeals = [];
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Map<String,bool> filterData){
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal){
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
      ),
      home: TabsScreen(_favoriteMeals),
      routes: {
        '/category-meals': (ctx) => CategoryMealsScreen(_availableMeals),
        '/meal-detail': (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        '/filter': (ctx) => FilterScreen(_setFilters,_filters),
      },
      /*onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },*/
        onUnknownRoute: (settings){
          return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
        },
    );
  }
}
