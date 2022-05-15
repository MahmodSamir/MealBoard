import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_ingredients/pages/countryItems.dart';
import 'package:recipe_ingredients/widgets/card.dart';
import 'package:recipe_ingredients/widgets/itemCards.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cnts = ["مصر","المغرب"];
  //cats.shuffle();
  List<String> cats=["دجاج","مأكولات بحرية"];

 sfl ()
  {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Items").doc(cnts[0]).collection(cnts[0]).doc(cats[0]).collection(cats[0]).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: 2,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return itemCards(x['url'], x['RecipeName'], x['RecipeTime'], x['Ingredients'], x['Recipe'],"","",x.id);
                });
            }
                return Center(
                  child:CircularProgressIndicator());
          },
          );
  }
  sfl1 ()
  {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Items").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: 3,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return country_items(x.id,x['img']);
                });
            }
                return Center(
                  child:CircularProgressIndicator());
          },
          );
  }
  @override
  void initState() {
   cats.shuffle();
   cnts.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
       appBar: AppBar(
         centerTitle: true,
        title: Row(
          children:[
             Image(image: AssetImage('assets/LogoGOLD.png'),fit: BoxFit.cover,height: 145,width: 145,alignment: Alignment.bottomRight,), 
            Text("الرئيسية"),
          ]
        ),
    
        backgroundColor: Color(0xff174354),
        automaticallyImplyLeading: false,
       ),
      body: 
               Stack(
                 children:[ Row(
                     children: <Widget>[
                       Expanded(
                         child: SizedBox(
                           height: 200.0,
                           child: sfl1(),
                           ),
                         ),
                     ],
                       ),
                 
        Container(child:sfl(),margin:EdgeInsets.only(top: 195),), 
    
                 ],
               ),
        
      ),
    );
  }
 /* Widget _ok(){
    return ListView.builder(
      itemCount: 3,
      itemExtent: 1000,
     itemBuilder: (BuildContext context, int index){
     return sfl();
     },
    );
  }*/
}


