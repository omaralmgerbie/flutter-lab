import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localToShow.dart';


class localStorage extends StatefulWidget {
  const localStorage({Key key}) : super(key: key);


  @override
  _localStorageState createState() => _localStorageState();
}


Future<bool> saveString(String S) async {

  SharedPreferences prf= await SharedPreferences.getInstance();
  prf.setString("name", S);
  return prf.commit();

}
Future<String>getString() async {

  SharedPreferences prf= await SharedPreferences.getInstance();
  String name = prf.getString("name");
  return name;

}
 final ctrlName= new TextEditingController();
class _localStorageState extends State<localStorage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(child: ListView(
            children: [
              TextField(
            controller: ctrlName,
            autofocus: false,
            decoration: InputDecoration( hintText: 'Name', contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
            ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),),
                  onPressed: () {
                    saveName();
                    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                    print(getString());
                    //Navigator.push(context,MaterialPageRoute(builder: (context) => localToShow()),);
                                }
                  ,padding: EdgeInsets.all(12),
                  color: Colors.lightBlueAccent,
                  child: Text('الصفحة التالية', style: TextStyle(color: Colors.white)),
                ),
              ),

            ],



          )
          ),
      ),
    ),
    );
  }
  static String routeName="/localToShow";
  void saveName(){
 String n=ctrlName.text;
 print("ssssssssssssssssssss");
 print(n);
 saveString(n).then((_) => Navigator.pushNamed(context, _localStorageState.routeName));
 //Navigator.push(context,MaterialPageRoute(builder: (context) => localToShow()),);

  }

}
