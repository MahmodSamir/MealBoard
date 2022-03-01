import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../dummy_data.dart';

class Details extends StatelessWidget {
    final String ing;
    final String steps;
    final String url;
    final String name;
  const Details(this.name, this.url, this.ing, this.steps);
  
  

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
  //  final mealID = ModalRoute.of(context)!.settings.arguments as String;
   // final selectedMeal = DUMMY_mealS.firstWhere((meal) => meal.id == mealID);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff174354),
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(url,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => 
                //Column
                Card(
                  color: Colors.grey,
                  child: Padding(padding: const EdgeInsets.symmetric(vertical:5, horizontal: 10),
                  child: Text(ing),
                  ),
                  //children: [
                   // ListTile(
                 /* leading: CircleAvatar(
                    backgroundColor: Colors.teal[500],
                    child: Text("#${index+1}"),
                  ),*/
                  //title: Text(ing),
                //),
                //Divider(),  
                  //],
                ),    
               itemCount: 1,
              ),
            ),
            buildSectionTitle(context, "Steps"),
            buildContainer( ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal[500],
                    child: Text("#${index+1}"),
                  ),
                  title: Text(steps),
                ),
                Divider(),  
                  ],
                ),    
                itemCount: 1,
              ),)
          ],
        ),
      ),
    /*  floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff449f96),
        onPressed: ()=> togglefav(mealID),
        child: Icon(
          isfavorite(mealID) ? Icons.favorite_sharp : Icons.favorite_outline
          ),
      ),*/
    );
  }
}
