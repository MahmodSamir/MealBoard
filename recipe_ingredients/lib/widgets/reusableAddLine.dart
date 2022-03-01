import 'package:flutter/material.dart';

class ReusableAddLine extends StatelessWidget {
    ReusableAddLine({required this.text, required this.onTap});
    final String text;
    final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text(
              text, style: TextStyle(decoration: TextDecoration.underline,color: Colors.black,fontSize: 20),
            ),
            SizedBox(width: 10,),
            Icon(Icons.cloud_upload),
          ],
        ),
          onTap: ()=> onTap,
      )
    );
  }
}