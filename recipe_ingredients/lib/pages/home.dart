import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'countryItems.dart';
import 'itemCardsV2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cnts = ["مصر", "المغرب"];
  List<String> cats = ["دجاج", "مأكولات بحرية"];

  items(int i) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Items")
          .doc(cnts[i])
          .collection(cnts[i])
          .doc(cats[i])
          .collection(cats[i])
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.size == 0) {
          return Center(child: Text("لا يوجد عناصر"));
        } else {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return itemCards2(x['url'], x['RecipeName'], x['RecipeTime'],
                    x['Ingredients'], x['Recipe'], "", "", x.id);
              });
        }
      },
    );
  }

  countries() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Items").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.data?.size == 0) {
          return Center(child: Text("لا يوجد عناصر"));
        } else {
          return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                return country_items(x.id, x['img']);
              });
        }
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
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Row(children: [
            Image(
              image: AssetImage('assets/LogoGOLD.png'),
              fit: BoxFit.cover,
              height: 145,
              width: 145,
              alignment: Alignment.bottomRight,
            ),
            Text("الرئيسية"),
          ]),
          backgroundColor: Color(0xff174354),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                    height: 250.0,
                    child: countries(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200,
            ),
            Padding(padding: EdgeInsets.all(100)),
            Container(
              height: 200,
              child: items(0),
              margin: EdgeInsets.only(top: 195),
            ),
            Container(
              margin: EdgeInsets.only(top: 375),
              child: Divider(
                color: Colors.black26,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Container(
              height: 200,
              child: items(1),
              margin: EdgeInsets.only(top: 395),
            ),
          ],
        ),
      ),
    );
  }
}
