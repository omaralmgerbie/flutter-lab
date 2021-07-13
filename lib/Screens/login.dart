import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_itmc323/Firebase/Firebase.dart';
import 'package:project_itmc323/Screens/home.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum FormType { login, register }

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController writerController = TextEditingController();
  String _result = 'No result yet';

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();

  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        hintColor: Colors.blueAccent,
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.blueAccent, size: 30),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "images/logo.png",
                      scale: 4,
                    ),
                    Text("تطبيق الواحد بتع الواحد",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'noor')),
                    Text("Wahed bt3 el-Wahed",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontFamily: 'noor')),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          new Container(
                            child: new TextField(
                              controller: _emailFilter,
                              decoration:
                                  new InputDecoration(labelText: 'الايميل'),
                            ),
                          ),
                          new Container(
                            child: new TextField(
                              controller: _passwordFilter,
                              decoration:
                                  new InputDecoration(labelText: 'رمز السري'),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 200,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                try {
                                  await getData(
                                      _emailFilter.text, _passwordFilter.text);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home(),
                                    ),
                                  );
                                } catch (e) {
                                  print(e.toString());
                                  Alert(
                                    context: context,
                                    title: "رقم السري غير صحيح",
                                    desc: "الرجاء اعدة المحاولة",
                                  ).show();
                                }
                              },
                              child: Center(
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'noor'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
