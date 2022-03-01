import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../widgets/mealItems.dart';

class categoryMeals extends StatefulWidget {
  const categoryMeals({ Key? key }) : super(key: key);

  @override
  _categoryMealsState createState() => _categoryMealsState();
}

class _categoryMealsState extends State<categoryMeals> {
  @override
  Widget build(BuildContext context) {
    final rot = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final ctgID = rot['id'];
    final ctgTitle = rot['title'];
    final ctgMeals = DUMMY_mealS.where((recipe) 
    {
      return recipe.categories.contains(ctgID);

    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(ctgTitle!),
        backgroundColor: Color(0xff174354),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index){
            return mealItems(ctgMeals[index].id,ctgMeals[index].imageUrl,ctgMeals[index].title, ctgMeals[index].duration);
        },
        itemCount: ctgMeals.length ,
      ),
    );
  }
}