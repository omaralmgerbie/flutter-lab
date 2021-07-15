import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab/screens/AuthScreen/login.dart';
import 'package:lab/screens/home.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;
  //final user = FirebaseAuth.instance.currentUser;


  @override

  Widget build(BuildContext context) {
   Future.delayed( Duration (seconds :2),(){

      if(auth.currentUser == null){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false);

      }
      else
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) => false);

   });
    return Scaffold(
     body: Center(
       child: FlutterLogo(size: 88),
     ),
    );
  }
}

