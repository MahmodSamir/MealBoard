import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:recipe_ingredients/widgets/reusableAddLine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeAdd extends StatefulWidget {
  const RecipeAdd({Key? key}) : super(key: key);

  @override
  _RecipeAddState createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {
  late File _image;
  final picker = ImagePicker();
  final _firestore = FirebaseFirestore.instance;
  late String downloadUrl;
  final CollectionReference getList =FirebaseFirestore.instance.collection("Items");

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      print(_image.path);
    });
  }

  Future uploadIMG(BuildContext ctx) async {
    String filename = basename(_image.path);
    FirebaseStorage firebaseStorageRef = FirebaseStorage.instance;
    Reference ref = firebaseStorageRef.ref().child("image");
    UploadTask uploadTask = ref.putFile(_image);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    downloadUrl = imageUrl.toString();
  }

  Future fetchData() async {
    try{
      await getList.get();
      print(getList);
    }
    catch(e){}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Recipe")),
        body: ListView(
          children: [
            Column(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      Text("add"),
                    ],
                  ),
                  onTap: () {
                    getImage();
                  },
                ),
                RaisedButton(
                    onPressed: () {
                      uploadIMG(context);
                      _firestore.collection('Items').add({
                        'Image': "gg",
                        'url': downloadUrl,
                      });
                    },
                    child: Text('add')),
                    RaisedButton(onPressed: () {
                      fetchData();
                    })
              ],
            )
          ],
        ));
  }
}
