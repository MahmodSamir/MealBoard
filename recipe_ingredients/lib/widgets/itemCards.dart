import 'package:flutter/material.dart';
import 'package:recipe_ingredients/pages/Details.dart';

class itemCards extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String duration;
  final String ing;
  final String steps;

  const itemCards(@required this.imageUrl,@required this.title, @required this.duration, this.ing, this.steps);

  void selectMeal(BuildContext ctx) {
     Navigator.push(
    ctx,
    MaterialPageRoute(builder: (context) =>  Details(title, imageUrl, ing, steps)),
  );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () => selectMeal(context), 
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover,),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        width: 220,
                        color: Colors.black54,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(title,
                         style:
                          TextStyle(fontSize: 26,
                           color: Colors.white),
                            softWrap: true,
                             overflow: TextOverflow.fade
                             ),
                      ),
                    ),
                  ],
                ),
              Padding(padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer),
                      SizedBox(width: 6),
                      Text("$duration min"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.favorite_border_outlined),
                    ],
                  ),
                ],         
              ),
              ),
              ],
            ),
          ),
      ),
    );
  }
}