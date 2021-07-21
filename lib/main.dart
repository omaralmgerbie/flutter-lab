import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'localStorage.dart';




void main() async {WidgetsFlutterBinding.ensureInitialized();await Firebase.initializeApp();runApp(MyApp());}

class MyApp extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

final   email= new TextEditingController();
 final pass= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
           // logo,
            SizedBox(height: 48.0),
        TextFormField(controller: email, autofocus: false,  decoration: InputDecoration( hintText: 'Email', contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),),
            SizedBox(height: 8.0),
          TextFormField(controller: pass,  autofocus: false, obscureText: true, decoration: InputDecoration(hintText: 'Password',  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0), border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),),

            SizedBox(height: 24.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
       //      Navigator.push(context,MaterialPageRoute(builder: (context) => homepage()),);
               Map<String,dynamic> data={"email":email.text,"password":pass.text};
             var a=  FirebaseFirestore.instance.collection("login").add(data);
                }
             ,padding: EdgeInsets.all(12),
             color: Colors.lightBlueAccent,
              child: Text('ادخل البيانات', style: TextStyle(color: Colors.white)),
            ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => localStorage()),);
                 }
                 ,padding: EdgeInsets.all(12),
                color: Colors.lightBlueAccent,
                child: Text('صفحة الlocal', style: TextStyle(color: Colors.white)),
              ),
              ) ,


            CachedNetworkImage(
              placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl:
              'https://i.pinimg.com/originals/cf/6e/ce/cf6ecee2363371d955f74cb3a0cb2001.jpg',
            ),
           // forgotLabel
          ],
        ),
      ),
    );
  }
}


