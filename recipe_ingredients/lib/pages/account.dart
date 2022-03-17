import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat.dart';
import 'login.dart';
import 'myProfile.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        leading: BackButton(),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          ProfileMenu(
            text: 'My Account',
            icon: Icons.account_circle,
            onpressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>myProfile()));
            },
          ),
          ProfileMenu(
            text: 'Chat with admin',
            icon: Icons.chat_bubble_rounded,
            onpressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Chat()));
            },
          ),
          ProfileMenu(
            text: 'About',
            icon: Icons.info,
            onpressed: () {},
          ),
          ProfileMenu(
            text: 'Log out',
            icon: Icons.logout,
            onpressed: () {
              _auth.signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onpressed})
      : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onpressed,
        color: Color(0xfff5f6f9),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(
              width: 20,
            ),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
