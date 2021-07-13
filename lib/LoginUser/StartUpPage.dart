import 'package:flutter/material.dart';
import 'package:noteapp/LoginUser/AuthType.dart';
import 'MyForm.dart';

import '../cusWidget/buttonWidget.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(),
              Image.asset('assets/imgs/applogo.jpg'),
              Text(
                  'هيا بنا!',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16,wordSpacing: 2
                  ),
              ),
              ButtonWidget(
                text: 'مرحبا بك',
                onPressed: () {  Navigator.of(context)
                    .pushReplacement(  MaterialPageRoute(builder: (BuildContext context) => FormFile(AuthType.login))); },
                bgColor: 0xFF17eb8a,
                textColor: Colors.white,
              ),
              // some code here ...
            ],
          ),
        ),
      ),
    );
  }
}
