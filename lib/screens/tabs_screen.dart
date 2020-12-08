import 'package:flutter/material.dart';

import '../screens/categories_screen.dart';
import '../screens/favorite_screen.dart';
import '../widget/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
       length: 2,
        child: Scaffold(
          drawer: MainDrawer(),
          appBar: AppBar(title: Text('Meals'),bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorite',
              ),
            ],
          ),),
          body: TabBarView(
            children: <Widget>[
              CategoriesScreen(),
              FavoriteScreen(widget._favoriteMeals)
            ],
          ),
        ),
    );
  }
}
