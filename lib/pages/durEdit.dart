import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_ingredients/pages/Details.dart';

class durEdit extends StatefulWidget {
  final String category;
  final String country;
  final String docID;
  final String title;
  final String ing;
  final String steps;
  final String url;
  final String duration;

  const durEdit(this.category, this.country, this.docID, this.title, this.ing,
      this.steps, this.url, this.duration);

  @override
  _durEditState createState() => _durEditState();
}

class _durEditState extends State<durEdit> {
  final _firestore = FirebaseFirestore.instance;
  late var dur;
  bool showSpinner = false;

  @override
  void intistate() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff174354),
        title: Text(
          " تحديث مدة تحضير ${widget.title}",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(50),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'ادخل مدة التحضير',
                      labelStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 7,
                    onChanged: (val) {
                      dur = val;
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                ButtonTheme(
                  height: 50,
                  minWidth: 150,
                  child: RaisedButton(
                    onPressed: () async {
                      _firestore
                          .collection("Items")
                          .doc(widget.country)
                          .collection(widget.country)
                          .doc(widget.category)
                          .collection(widget.category)
                          .doc(widget.docID)
                          .update({
                        'RecipeTime': dur,
                      }).then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details(
                                      widget.title,
                                      widget.url,
                                      dur,
                                      widget.ing,
                                      widget.steps,
                                      widget.category,
                                      widget.country,
                                      widget.docID))));
                    },
                    child: Text(
                      'حدث المدة',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.teal[500],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
