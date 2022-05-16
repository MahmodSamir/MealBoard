import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:recipe_ingredients/pages/navigationBar.dart';
import 'adminNavBar.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late String email, password;
  var _formkey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  bool visiblityPassword = true;
  bool spinner = false;
  var email_vaildator = MultiValidator([
    EmailValidator(errorText: 'البريد الالكتروني غير صحيح'),
    RequiredValidator(errorText: 'البريد الالكتروني مطلوب'),
  ]);
  var password_validator = MultiValidator([
    RequiredValidator(errorText: 'كلمة المرور مطلوبة'),
    MinLengthValidator(8, errorText: 'يجب ان لا تقل كلمة المرور عن 8 احرف'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'يجب ان تحتوي كلمة المرور على علامة مميزة واحدة على الاقل'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff174354),
        title: Text(
          "تسجيل الدخول",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Builder(builder: (context) {
          return ModalProgressHUD(
            inAsyncCall: spinner,
            child: ListView(
              padding: EdgeInsets.all(15),
              children: [
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          validator: email_vaildator,
                          onChanged: (val) {
                            email = val;
                          },
                          decoration: const InputDecoration(
                            hintText: "البريد الالكتروني",
                            labelText: "البريد الالكتروني",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: password_validator,
                          obscureText: visiblityPassword,
                          onChanged: (val) {
                            password = val;
                          },
                          decoration: InputDecoration(
                            hintText: "كلمة المرور",
                            labelText: "كلمة المرور",
                            suffixIcon: IconButton(
                              icon: Icon(
                                  visiblityPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.indigo),
                              onPressed: () {
                                setState(() {
                                  visiblityPassword = !visiblityPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    )),
                FlatButton(
                    color: Colors.teal[500],
                    padding: EdgeInsets.all(20),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        var connectivityResult =
                            await (Connectivity().checkConnectivity());
                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('لا يوجد اتصال بالانترنت')));
                        } else {
                          try {
                            setState(() {
                              spinner = false;
                            });

                            if (email == 'admin@gmail.com') {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => adminNavBar()));
                            } else {
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => bottomNavBar()));
                            }
                          } catch (e) {
                            setState(() {
                              spinner = false;
                            });
                            if (e is FirebaseAuthException) {
                              if (e.code == 'user-not-found') {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('مستخدم غير موجود')));
                              } else if (e.code == 'wrong-password') {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('كلمة المرور خاطئة')));
                              }
                            }
                          }
                        }
                      }
                    },
                    child: Text(
                      'الدخول',
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'لا تملك حساب؟',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black38,
                          ),
                        ),
                        Text(
                          'قم بانشاء حساب  ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        }),
      ),
    );
  }
}
