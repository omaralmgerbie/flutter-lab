import 'package:flutter/material.dart';
import 'package:noteapp/LoginUser/StartUpPage.dart';
import 'package:noteapp/SomeFunction/singletonClass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListOfNotes.dart';
import 'ViewNote.dart';
import 'ViewType.dart';

class HomePageNote extends StatefulWidget {
  @override
  _HomePageNoteState createState() => _HomePageNoteState();
}

class _HomePageNoteState extends State<HomePageNote> {
  Future<void> singOut(BuildContext context) async {
    SharedPreferences pref=await Singleton.getPrefInstace();
    pref.remove('uid');
    pref.remove('email');

    Singleton.getFireAuthInstace().signOut().then((value) =>
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> StartUp()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.logout),onPressed: () {
          singOut(context);
        },),
        title: Text("الصفحة الرئيسية"),
        centerTitle: true,
        titleSpacing: 1,
      ),
      body: NoteList(),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(  MaterialPageRoute(builder:
              (BuildContext context) => Note(ViewType.saveNote )));
        },
       label: const Text('إضافة ملاحظة'),
        icon: const Icon(Icons.note_add),
        backgroundColor: Colors.green  ,
      ),

    );
  }
}
