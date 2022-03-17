import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _auth =FirebaseAuth.instance;
  late String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Color(0xff174354),
        titleSpacing: 30,
        title: Text(
          "Reset Password",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView(

        children: [
          SizedBox(
            height: 40,
          ),
          Form(

            child: Padding(
              padding: EdgeInsets.all(8),
              child: TextFormField(
                  validator: MultiValidator([
                    EmailValidator(errorText: 'Email not valid'),
                    RequiredValidator(errorText: 'Email is required'),
                  ]),
                  onChanged: (val) {
                    email = val;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email",
                    labelText: "email",
                    border: OutlineInputBorder(),
                  ),
              ),

            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  FlatButton(
                  color: Colors.teal[300],
                  padding: EdgeInsets.symmetric(horizontal: 90),
                  onPressed: (){
                    _auth.sendPasswordResetEmail(email: email);
                    Navigator.of(context).pop();
                  },
                  child: Text('Send Request')),
                ],
          )
        ],
      ),
    );
  }
}
