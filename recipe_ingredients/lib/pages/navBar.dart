import 'package:flutter/material.dart';
import 'package:recipe_ingredients/models/meal.dart';
import 'package:recipe_ingredients/pages/categoryMeals.dart';
import 'package:recipe_ingredients/pages/filtercountries.dart';
import 'package:recipe_ingredients/pages/mealDetails.dart';
import '/pages/Favorite.dart';

class NavBar extends StatefulWidget {
//  const NavBar({ Key? key }) : super(key: key);
  final List<meal> favoriteMeal;

   NavBar(this.favoriteMeal);
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  
   late List pages; 


  int selectPageIndex = 0;

  void initState(){
   pages = [
    {
      'page': FilterCountry(),
      'label': 'Categories',
    },
    {
      'page': Favorite(widget.favoriteMeal),
      'label': "Favorites", 
    },
  ];
  super.initState();
  }

  void selectPage(int value){
    setState(() {
      selectPageIndex = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[selectPageIndex]['label']),
        backgroundColor: Color(0xff174354),
        ),

      body: pages[selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Color(0xff174354),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        currentIndex: selectPageIndex,
         items: const [
           /*BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: "details"
             ),*/
           BottomNavigationBarItem(
             icon: Icon(Icons.filter_alt),
             label: "Categories",
             ),
           BottomNavigationBarItem(
             icon: Icon(Icons.favorite),
             label: "Favorites",
             ),
          /* BottomNavigationBarItem(
             icon: Icon(Icons.account_circle),
             label: "meals"
             ),*/
         ],
      ),
      
    );
  }
}