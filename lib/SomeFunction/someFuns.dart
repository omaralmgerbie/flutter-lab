import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteapp/NoteFiles/home.dart';
import 'package:http/http.dart' as http;

void showShortToast(String meg ,Color color) {
  Fluttertoast.showToast(
      msg: "$meg",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void  onLoading(BuildContext context) {
  showDialog(
    // child:Text("يتم تجهيز النظام"),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                new Text("انتظر قليلا" ,style: TextStyle(fontSize: 16), ),
              ],
            ),
          ),
        ),
      );
    },
  );

  new Future.delayed(new Duration(seconds: 1), () {
    Navigator.pop(context); //pop dialog
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        HomePageNote( )));
  });
}


Future<String>  getDataFromApi() async{
  try{
    var resp= await http.get('https://www.colr.org/json/colors/random/1');
    if(resp.statusCode==200){
      var obj=json.decode(resp.body);
      print("the resp from Api ${obj['colors'][0]["hex"]}");
      return obj['colors'][0]["hex"];
    }
    return null;
  }on Exception catch (e){
    print(e);
  }
}

