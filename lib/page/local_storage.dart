
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageLocalPage extends StatefulWidget {

  @override
  _StorageLocalPageState createState() => _StorageLocalPageState();


}

class _StorageLocalPageState extends State<StorageLocalPage> {
  final TextEditingController _enterData = TextEditingController();

  String _savedData = '';
  String _gotData = '';
  String something = '';
@override
  void initState() {
    // TODO: implement initState
  super.initState();
  _loadSaveData();
  }
  @override

  _loadSaveData()  async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    setState(() {
      if(prefs.getString('key_name')!= null && prefs.getString('key_name')!.isNotEmpty ){

      _savedData = prefs.getString('key_name')!;
      print("Success");
    }else{
        _savedData='Nothing Saved in SP';
      }
      });

  }
  _saveData( String message)  async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    setState(() async {
      _gotData = prefs.setString('key_name', message) as String;
      print("Success");
    });

      }

  _getData()  async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    setState(() {
      if(prefs.getString('key_name')!= null && prefs.getString('key_name')!.isNotEmpty ){

        something = prefs.getString('key_name')!;
        print("Success");
      }else{
        something='Nothing Saved in SP';
      }
    });
     print("Got Data");

  }


_deleteData() async {
  SharedPreferences prefs  = await SharedPreferences.getInstance();
   prefs.remove('key_name');
   print("Got deleted");
}


    Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
           children: [
                 Container(
               child: ListTile(
            title: TextField(
              controller: _enterData,
              decoration:InputDecoration(
                labelText: "Write Something",
              ) ,
            ),
                ),
     ),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children:[
                     Padding(padding: EdgeInsets.all(10)),
                     Text(" The last you entered was : $_savedData"),
                     ElevatedButton(onPressed: (){

                       _saveData(_enterData.text);
                     }, child: Text("Save"))

                   ],
                 ),

               ),
             ),

             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children:[
                     Padding(padding: EdgeInsets.all(10)),
                     Text(" you entered : $something"),
                     ElevatedButton(onPressed: (){
                       _getData();
                     }, child: Text("get"))

                   ],
                 ),

               ),
             ),
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Container(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children:[
                     Padding(padding: EdgeInsets.all(10)),
                     //Text(" you delete : "),
                     ElevatedButton(onPressed: (){
                       _deleteData();
                     }, child: Text("Delete"))

                   ],
                 ),

               ),
             ),


           ],

            ),


          ),
      ),


    );
  }
}
