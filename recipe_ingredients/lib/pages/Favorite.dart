import 'package:flutter/material.dart';
import 'package:recipe_ingredients/models/meal.dart';
import 'package:recipe_ingredients/widgets/mealItems.dart';

class Favorite extends StatelessWidget {

 final List<meal> favoriteMeals;

   Favorite(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {

    if(favoriteMeals.isEmpty){
    return Center(
      child: Text("You have no favorites yet."), 
    );
    }
    else{
      return ListView.builder(
        itemBuilder: (ctx, index){
            return mealItems(favoriteMeals[index].id,favoriteMeals[index].imageUrl,favoriteMeals[index].title, favoriteMeals[index].duration);
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}