import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Edit extends StatefulWidget {
  final String category;
  final String docID;
  
  const Edit(this.category,  this.docID );

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var _image;
  late var Ingredients;
  late var RecipeName;
  late var Recipe;
  late var RecipeTime;
  late User logeInUser;
  late String recipeName;
  late String downloadUrl;
  late String recipe;
  late var photo;
  late double long, lat;
  final picker = ImagePicker();
  bool showSpinner = false;

  @override
  void intistate() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      logeInUser = user;
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedfile!.path );
    });
  }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(_image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(fileName);
    UploadTask uploadTask = ref.putFile(_image);
    setState(() {
      showSpinner = true;
    });
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    downloadUrl = imageUrl.toString();
    setState(() {
      showSpinner = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color(0xff174354),
            titleSpacing: 30,
            title: Text("Edit a new item",style: TextStyle(fontSize: 30),
            ),
          ),
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Card(
                          child:
                          (_image!=null)
                              ?Image.file(_image,width: 100, height: 100,fit: BoxFit.fill,)
                              :Image(image: AssetImage ('images/Edit.png'),width: 60,height: 60,)
                        ),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Edit Image',
                                style: TextStyle(
                                  color: Colors.teal[600],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              Icon(Icons.add_circle,color: Colors.teal[500],),
                            ],
                          ),
                          onTap: getImage,
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter the Name',
                              labelStyle:TextStyle(fontSize: 20),
                            ),
                            onChanged: (val){
                              RecipeName =val;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter the Recipe time',
                              labelStyle:TextStyle(fontSize: 20),
                            )
                            ,keyboardType: TextInputType.number,
                            onChanged: (val){
                              RecipeTime =val;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter the Ingredients',
                              labelStyle:TextStyle(fontSize: 20),
                            ),
                            maxLines: 7,
                            onChanged: (val){
                              Ingredients =val;
                            },
                          ),
                        ),
          
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'Enter the Recipe',
                              labelStyle:TextStyle(fontSize: 20),
                            ),
                            maxLines: 7,
                            onChanged: (val){
                              Recipe =val;
                            },
                          ),
                        ),
            
                        Padding(padding: EdgeInsets.all(10)),
                        RaisedButton(
                          onPressed: () async {
                            await uploadPic(context);
                            _firestore.collection("Items").doc(widget.category).collection(widget.category).doc(widget.docID).update({
                              'url': downloadUrl,
                              'Recipe' : Recipe,
                              'Ingredients' : Ingredients,
                              'RecipeName': RecipeName,
                              'RecipeTime': RecipeTime
                            }
                            );
                            _firestore.collection("Items").doc(widget.category).set({
                            'dummy': widget.category
                            
                            });

                          },
                          child: Text('upload Image'),
                          color: Colors.teal[500],
                        ),
                      ],
                    )
                  ],
                ),
          ),
            );
  }
}
