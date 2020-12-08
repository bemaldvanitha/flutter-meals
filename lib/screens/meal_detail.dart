import 'package:flutter/material.dart';

import 'package:mealsapp/models/meal.dart';
import '../data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  final Function toggleFavorite;
  final Function isFavorite;
  MealDetailScreen(this.toggleFavorite,this.isFavorite);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((meal){
      return meal.id == mealId;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text('Ingredients',style: Theme.of(context).textTheme.title,),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: 150,
              width: 300,
              child: ListView.builder(
                  itemBuilder: (ctx,index){
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                        child:Text(
                          meal.ingredients[index]
                      ),)
                    );
                  },
                  itemCount: meal.ingredients.length,
              )
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text('Steps',style: Theme.of(context).textTheme.title,),
            ),
            Container(
              width: 300,
              height: 150,
              child: ListView.builder(
                  itemBuilder: (ctx,index){
                    return ListTile(
                      leading: Text('#'+index.toString()),
                      title: Text(meal.steps[index]),
                    );
                  },
                  itemCount: meal.steps.length,
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            isFavorite(mealId) ?Icons.favorite : Icons.favorite_border
        ),
        onPressed: (){
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
