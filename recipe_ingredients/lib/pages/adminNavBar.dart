import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'adminProfile.dart';
import 'adminAdd.dart';
import 'filtercountries.dart';
import 'home.dart';
import 'login.dart';

class adminNavBar extends StatefulWidget {
  const adminNavBar({Key? key}) : super(key: key);

  @override
  _adminNavBarState createState() => _adminNavBarState();
}

class _adminNavBarState extends State<adminNavBar> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late List pages;
  LogOut() {
    _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

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
        'page': Add(),
      },
      {
        'page': adminAcc(),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_alt),
            label: "التصنيفات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "اضافة",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "الحساب",
          ),
        ],
      ),
    );
  }
}
