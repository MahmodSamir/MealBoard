import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_plus/share_plus.dart';
import 'imgEdit.dart';
import 'ingEdit.dart';
import 'stepsEdit.dart';
import '../widgets/itemCards.dart';

class Details extends StatefulWidget {
  final String ing;
  final String steps;
  final String url;
  final String duration;
  final String name;
  final String category;
  final String country;
  final String docID;

  Details(this.name, this.url, this.duration, this.ing, this.steps,
      this.category, this.country, this.docID);

  State<Details> createState() => _Details();
}

class _Details extends State<Details> {
  bool _isFavorited = false;

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
          color: Colors.grey[100],
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
    final itemCards fav = new itemCards(
        widget.url,
        widget.name,
        widget.duration,
        widget.ing,
        widget.steps,
        widget.category,
        widget.country,
        widget.docID);
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future addToFavorite() async {
      //isfav = true;
      final FirebaseAuth auth = FirebaseAuth.instance;
      var currentUser = auth.currentUser;
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection("users-favorites");
      return collectionRef
          .doc(currentUser!.email)
          .collection("items")
          .doc(widget.name)
          .set({
        'url': widget.url,
        'Recipe': widget.steps,
        'Ingredients': widget.ing,
        'RecipeName': widget.name,
        'RecipeTime': widget.duration,
      });
    }

    Future unFavorite() async {
      // isfav = false;
      final FirebaseAuth auth = FirebaseAuth.instance;
      var currentUser = auth.currentUser;
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection("users-favorites");
      return collectionRef
          .doc(currentUser!.email)
          .collection("items")
          .doc(widget.name)
          .delete();
    }

    Future delete() async {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection("Items");
      return collectionRef
          .doc(widget.country)
          .collection(widget.country)
          .doc(widget.category)
          .collection(widget.category)
          .doc(widget.docID)
          .delete();
    }

    isfav() async {
      final snap = await FirebaseFirestore.instance
          .collection("users-favorites")
          .doc(auth.currentUser!.email)
          .collection("items")
          .doc(widget.name)
          .get();
      if (snap.exists && _isFavorited) {
        setState(() {
          _isFavorited = false;
          unFavorite();
        });
      } else {
        setState(() {
          _isFavorited = true;
          addToFavorite();
        });
      }
    }

    sharing() {
      try {
        Share.share("مشاركة وصفة ${widget.name} من تطبيق كذا"
            "\n\n\n"
            "مدة التحضير"
            "\t"
            "${widget.duration} دقيقة"
            "\n\n\n"
            "المكونات"
            "\n"
            "${widget.ing}"
            "\n\n\n"
            "طريقة التحضير"
            "\n"
            "${widget.steps}"
            "\n\n\n"
            "صورة"
            "\n\n"
            "${widget.url}");
      } catch (e) {
        print(e);
      }
    }

    bool _isShown = true;

    void _delete(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text('برجاء التأكيد'),
                content: Text("هل انت متأكد من مسح ${widget.name}؟"),
                actions: [
                  // The "Yes" button
                  TextButton(
                      onPressed: () {
                        delete();
                        setState(() {
                          Navigator.of(context).pop();
                        });

                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text('نعم')),
                  TextButton(
                      onPressed: () {
                        // Close the dialog
                        Navigator.of(context).pop();
                      },
                      child: const Text('لا'))
                ],
              ),
            );
          });
    }

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
              IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 350),
                  iconSize: 35,
                  onPressed: () => _auth.currentUser?.email == 'admin@gmail.com'
                      ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => imgEdit(
                                        widget.category,
                                        widget.country,
                                        widget.docID,
                                        widget.name,
                                        widget.ing,
                                        widget.steps,
                                        widget.url,
                                        widget.duration,
                                      )))
                          .then((value) => Navigator.of(context).pop())
                      : sharing(),
                  icon: _auth.currentUser?.email == 'admin@gmail.com'
                      ? Icon(Icons.photo_camera_back_outlined)
                      : Icon(Icons.share)),
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
                                        widget.category,
                                        widget.country,
                                        widget.docID,
                                        widget.name,
                                        widget.ing,
                                        widget.steps,
                                        widget.url,
                                        widget.duration)))
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
                  itemBuilder: (ctx, index) => Card(
                    color: Colors.grey[100],
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
                                        widget.category,
                                        widget.country,
                                        widget.docID,
                                        widget.name,
                                        widget.ing,
                                        widget.steps,
                                        widget.url,
                                        widget.duration)))
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
                  itemBuilder: (ctx, index) => Card(
                    color: Colors.grey[100],
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
          onPressed: () => _auth.currentUser?.email == 'admin@gmail.com'
              ? _delete(context)
              : isfav(),
          child: _auth.currentUser?.email == 'admin@gmail.com'
              ? Icon(Icons.delete)
              : Icon(_isFavorited
                  ? Icons.favorite_sharp
                  : Icons.favorite_border)),
    );
                                        
  }
}
