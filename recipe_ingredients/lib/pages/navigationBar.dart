import 'package:flutter/material.dart';
import 'package:recipe_ingredients/pages/account.dart';
import 'package:recipe_ingredients/pages/addRecipe.dart';
import 'package:recipe_ingredients/pages/favorites.dart';
import 'package:recipe_ingredients/pages/filtercountries.dart';
import 'package:recipe_ingredients/pages/home.dart';
import 'package:recipe_ingredients/pages/search.dart';
import 'chat.dart';
import 'adminAdd.dart';
import 'login.dart';
import 'register.dart';

class bottomNavBar extends StatefulWidget {
const bottomNavBar({ Key? key }) : super(key: key);

  @override
  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  
   late List pages; 


  int selectPageIndex = 0;

  void initState(){
   pages = [
    {
      'page': Home(),
      'label': "الرئيسية", 
    },
    /*{
      'page': Chat(),
      'label': 'chats',
    },*/
    {
      'page': FilterCountry(),
      'label': "البلاد", 
    },
     {
      'page': Add(),
      'label': "اضافة وصفة جديدة", 
    },
    {
      'page': Favorites(),
      'label': "المفضلة", 
    },
     {
      'page': Account(),
      'label': "الحساب", 
    },
     {
      'page': Search(),
      'label': "بحث", 
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
   /*   appBar: AppBar(
        title: Text(pages[selectPageIndex]['label']),
        backgroundColor: Color(0xff174354),
        ),*/

      body: pages[selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal[500],
        unselectedItemColor: Colors.black,
        currentIndex: selectPageIndex,
         items: const [
               BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: "الرئيسية"
             ),
      /*     BottomNavigationBarItem(
             icon: Icon(Icons.home),
             label: "Chats"
             ),*/
           BottomNavigationBarItem(
             icon: Icon(Icons.filter_alt),
             label: "الاقسام",
             ),
           BottomNavigationBarItem(
             icon: Icon(Icons.add),
             label: "اضافة",
             ),
              BottomNavigationBarItem(
             icon: Icon(Icons.favorite),
             label: "المفضلة"
             ),
              BottomNavigationBarItem(
             icon: Icon(Icons.account_circle),
             label: "حسابي"
             ),
              BottomNavigationBarItem(
             icon: Icon(Icons.search),
             label: "بحث"
             ),
         ],
      ),  
    );
  }
}