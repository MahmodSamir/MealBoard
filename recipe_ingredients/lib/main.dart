import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ingredients/dummy_data.dart';
import 'package:recipe_ingredients/models/meal.dart';
import 'package:recipe_ingredients/pages/navigationBar.dart';
import './pages/mealDetails.dart';
import './pages/navBar.dart';
import './pages/categoryMeals.dart';
import './pages/filterCategories.dart';
import './pages/Favorite.dart';
import 'pages/addRecipe.dart';
import 'pages/adminAdd.dart';
import 'pages/Recipes.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'pages/search.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var _ref = FirebaseDatabase.instance.ref().child("Value");
  _ref.set(3);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
      List<meal> _favoriteMeals = [];

      void favs(String mealID){
        final index = _favoriteMeals.indexWhere((meal) => meal.id == mealID);
        if(index >= 0){
          setState(() {
            _favoriteMeals.removeAt(index);
          });
        }
        else{
          setState(() {
            _favoriteMeals.add(DUMMY_mealS.firstWhere((meal) => meal.id == mealID));
          });
        }
      }

      bool isfav(String id){
        return _favoriteMeals.any((meal) => meal.id == id);
      }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: "",),
      routes: {
        'nav':  (context) => NavBar(_favoriteMeals),
        //'/fav': (context) => Favorite(),
        '/fltr': (context) => Filter(),
        '/ctgmls': (context) => categoryMeals(),
        '/dtls': (context) => mealDetails(favs, isfav),
        '/add': (context) => Add(),
        //'/dpl': (context) => Recipes(),
        '/log': (context) => Login(),
        '/reg': (context) => Register(),
        '/srch': (context) => Search(),
        '/navBar': (context) => bottomNavBar(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff174354),
          title: Text("APP"),
        ),
        body: Column(
          children: [
            RaisedButton(
              child: Text("To Filter"),
              onPressed: () => Navigator.pushNamed(context, '/fltr'),
            ),
            RaisedButton(
              child: Text("To Favorites"),
              onPressed: () => Navigator.pushNamed(context, '/fav'),
            ),
            RaisedButton(
              child: Text("To Add Recipe"),
              onPressed: () => Navigator.pushNamed(context, '/add'),
            ),
             RaisedButton(
              child: Text("To Show Recipe"),
              onPressed: () => Navigator.pushNamed(context, '/dpl'),
            ),
             RaisedButton(
              child: Text("To Login"),
              onPressed: () => Navigator.pushNamed(context, '/log'),
            ),
            RaisedButton(
              child: Text("To bottom"),
              onPressed: () => Navigator.pushNamed(context, '/navBar'),
            )
          ],
        ));
  }
}
