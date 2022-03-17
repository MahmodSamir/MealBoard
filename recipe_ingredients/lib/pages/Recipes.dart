import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ingredients/pages/Details.dart';
import 'package:recipe_ingredients/widgets/itemCards.dart';

class Recipes extends StatelessWidget {
  final String category;
   Recipes(this.category);
    final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text(category)),
      body:  StreamBuilder(
          stream: _firestore.collectionGroup(category).snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return itemCards(x['url'], x['RecipeName'], x['RecipeTime'], x['Ingredients'], x['Recipe'],category,x.id);
                });
            }
                return Center(
                  child: CircularProgressIndicator());
          },
          )
    /*  SingleChildScrollView(
        child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('مشروبات ساخنة').snapshots(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ),
                    );
                  }
                 final items =snapshot.data!.docs;
                  List<itemCards> itemslist = [];
                  for (var item in items){
                    String recipe = item['Recipe'];
                    String Url = (item['url']);
                    String Ingredients = (item['Ingredients']);
                    String recipename = (item['RecipeName']);
                    String recipetime = (item['RecipeTime']);
                    var itemList=itemCards(Url, recipename, recipetime,Ingredients ,recipe );
                    itemslist.add(itemList);
                  }
                  return ListView(children: itemslist,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
      
                  );
        /* StreamBuilder(
          stream: FirebaseFirestore.instance.collection("مشروبات ساخنة").snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,i){
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  return itemCards(x['url'], x['RecipeName'], x['RecipeTime'], x['Ingredients'], x['Recipe']);
                });
            }
                return Center(
                  child: CircularProgressIndicator());
          },
          )*/
                },
          ),
            ],
              ),
      )*/
    );
  }}