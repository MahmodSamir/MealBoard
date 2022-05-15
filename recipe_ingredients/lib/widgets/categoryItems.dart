import 'package:flutter/material.dart';
import 'package:recipe_ingredients/pages/Recipes.dart';

class category_items extends StatelessWidget {
  final String title;
  final String country;
  final String img;

  /*   final String id;

  final Color color; */
  //recieve title parameter
  category_items(this.title, this.country, this.img);

  void selectCategory(BuildContext ctx) {
    Navigator.push(
      ctx,
      MaterialPageRoute(builder: (context) => Recipes(title, country)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.zero,
        child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(img, height: double.infinity, width: double.infinity, fit: BoxFit.cover,),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: Container(
                          width: 120,
                          color: Colors.black54,
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          child: Text(title,
                          textDirection: TextDirection.rtl,
                           style:
                            TextStyle(fontSize: 15,
                             color: Colors.white,fontWeight: FontWeight.bold),
                              softWrap: true,
                               overflow: TextOverflow.fade
                               ),
                        ),
                      ),
                    ],
                  ),
        decoration: BoxDecoration(
          color: Colors.teal[500],
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
