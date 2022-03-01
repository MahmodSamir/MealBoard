import 'package:flutter/material.dart';
import 'package:recipe_ingredients/pages/Recipes.dart';

class category_items extends StatelessWidget {
final String title;
/*   final String id;
  
  final Color color; */
  //recieve title parameter
  category_items(this.title);

   void selectCategory(BuildContext ctx){
    Navigator.push(
    ctx,
    MaterialPageRoute(builder: (context) =>  Recipes(title)),
  );
  }
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.8),
              Colors.yellow,
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(15),

        ),
      ),
      
    );
  }
}