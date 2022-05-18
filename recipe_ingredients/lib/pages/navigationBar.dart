import 'package:flutter/material.dart';
import 'account.dart';
import 'favorites.dart';
import 'filtercountries.dart';
import 'home.dart';
import 'search.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({Key? key}) : super(key: key);

  @override
  _bottomNavBarState createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  late List pages;

  int selectPageIndex = 0;

  void initState() {
    pages = [
      {
        'page': Home(),
      },
      {
        'page': FilterCountry(),
      },
      {
        'page': Favorites(),
      },
      {
        'page': Account(),
      },
      {
        'page': Search(),
      },
    ];
    super.initState();
  }

  void selectPage(int value) {
    setState(() {
      selectPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: "التصنيفات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "المفضلات"
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
