import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_ingredients/widgets/itemCards.dart';
import 'imgEdit.dart';
import 'ingEdit.dart';
import 'stepsEdit.dart';
import '../widgets/itemCards.dart';
import 'globals.dart' as globals;

class Details extends StatefulWidget {
 
 final String ing;
  final String steps;
  final String url;
  final String duration;
  final String name;
  final String category;
  final String country;
  final String docID;

  Details(this.name, this.url, this.duration,this.ing, this.steps, this.category,
      this.country, this.docID);
 
   State<Details> createState() => _Details();
}
class _Details extends State<Details> {
   bool _isFavorited = true;

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

  var _auth = FirebaseAuth.instance;
  var logedInUSer;
  getCuurrentUser() {
    User? user = _auth.currentUser?.email as User?;
    logedInUSer = user?.email;
  }
   @override
  Widget build(BuildContext context) {
    final itemCards fav = new itemCards(widget.url, widget.name, widget.duration, widget.ing, widget.steps, widget.category, widget.country, widget.docID); 
    final FirebaseAuth auth = FirebaseAuth.instance;
isfav()
  async {
    final snap =await FirebaseFirestore.instance.collection("users-favorites").doc(auth.currentUser!.email)
        .collection("items")
        .doc(widget.name).get();
     if(snap.exists && _isFavorited){
       setState(() {
       _isFavorited = false;  
        fav.unFavorite();
       });
       

      
     }
     
     else{
       setState(() {
       _isFavorited=true;  
            fav.addToFavorite();           

       });
      
     
    }
    }
    /*void _toggleFavorite() {
  setState(() {
    if (_isFavorited) {
      _isFavorited = false;
    } else {
      _isFavorited = true;
    }
  });
}*/
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff174354),
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                ),
              ),
              Visibility(
                  child: IconButton(
                    padding: EdgeInsets.symmetric(horizontal: 350),
                    iconSize: 45,
                    onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    imgEdit(widget.category, widget.country, widget.docID, widget.name)))
                        .then((value) => Navigator.of(context).pop()),
                    icon: Icon(Icons.photo_camera_back_outlined),
                  ),
                  visible: _auth.currentUser?.email == 'admin@gmail.com'
                      ? true
                      : false),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSectionTitle(context, "المكونات"),
                  Visibility(
                      child: IconButton(
                        onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ingEdit(
                                        widget.category, widget.country, widget.docID, widget.name)))
                            .then((value) => Navigator.of(context).pop()),
                        icon: Icon(Icons.edit),
                      ),
                      visible: _auth.currentUser?.email == 'admin@gmail.com'
                          ? true
                          : false),
                ],
              ),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) =>
                      Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(widget.ing),
                    ),
                  ),
                  itemCount: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildSectionTitle(context, "طريقة التحضير"),
                  Visibility(
                      child: IconButton(
                        onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => stepsEdit(
                                        widget.category, widget.country, widget.docID, widget.name)))
                            .then((value) => Navigator.of(context).pop()),
                        icon: Icon(Icons.edit),
                      ),
                      visible: _auth.currentUser?.email == 'admin@gmail.com'
                          ? true
                          : false),
                ],
              ),
              buildContainer(
                ListView.builder(
                  itemBuilder: (ctx, index) =>  Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(widget.steps),
                    ),
                  ),
                  itemCount: 1,
                ),
              )
            ],
          ),
        ),
      ),
    
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff449f96),
        onPressed: ()=> isfav(),
        child: 
        Icon(
          _isFavorited ?   Icons.favorite : Icons.favorite_border_outlined  
          ),
      ),
    );
  }

}