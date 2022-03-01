import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ingredients/pages/dataControl.dart';
import '../widgets/categoryItems.dart';
import '../dummy_data.dart';

class Filter extends StatelessWidget {
  Filter({Key? key}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Filter")),
      body: StreamBuilder(
        stream: _firestore.collection("Items").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(25),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, i) {
                  QueryDocumentSnapshot x = snapshot.data!.docs[i];
                  print(x.id);
                  //Search(x.id);
                  return category_items(x.id);
                },
                itemCount: snapshot.data!.docs.length,
                );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
