import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ingredients/widgets/itemCards.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cats = ["بيتزا","مشويات","مأكولات بحرية","مشروبات ساخنة"];
  //cats.shuffle();
  List<String> rtv=[];
 sfl (int num)
  {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collectionGroup(cats[num]).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: 1,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return itemCards(x['url'], x['RecipeName'], x['RecipeTime'], x['Ingredients'], x['Recipe'],"مشويات",x.id);
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
   //sfl();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cats[1]),),
    body:  sfl(0),
    

     
  
 
         
      
    );
  }
}
