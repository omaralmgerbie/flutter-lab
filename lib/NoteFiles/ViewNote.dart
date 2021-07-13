import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/SomeFunction/singletonClass.dart';
import 'package:noteapp/SomeFunction/someFuns.dart';
import 'ViewType.dart';

class Note extends StatefulWidget {
  ViewType viewType; String postID ,noteName,  noteContent;
  Note( this.viewType , {this.noteName,this.noteContent,this.postID} );
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  FirebaseFirestore _firebaseFirestore=Singleton.getFireStoreInstance();
  final TextEditingController  _subjectController=  TextEditingController();
  final TextEditingController  _contentController=  TextEditingController();
  FirebaseAuth _fireinstance=Singleton.getFireAuthInstace();
  saveNote() {
    _firebaseFirestore.collection("Notes").doc().set({
      "NoteName":_subjectController.text  ,
      "NoteContent": _contentController.text,
      'UserID':_fireinstance.currentUser.uid,
    }).then((value) => showShortToast(widget.viewType==ViewType.saveNote?"تم إضافة الملاحظة":"تم التعديل بنجاح"  ,Colors.green)
    ).catchError((error)=>showShortToast("حدثت مشكلة" , Colors.red));
  }
  editNote() {
    _firebaseFirestore.collection("Notes").doc(widget.postID).update({
      "NoteName":_subjectController.text,
      "NoteContent":_contentController.text,
      'UserID':_fireinstance.currentUser.uid,
    }).then((value) => showShortToast(widget.viewType==ViewType.saveNote?"تم إضافة الملاحظة":"تم التعديل بنجاح"  ,Colors.green)
    ).catchError((error)=>showShortToast("حدثت مشكلة" , Colors.red));
  }
  @override
  void initState() {
    super.initState();
    if(widget.viewType==ViewType.editNote)
      {
        _subjectController.text=widget.noteName;
        _contentController.text=widget.noteContent;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.white,
        actions: [
         Padding(padding: EdgeInsets.all(5),child:  IconButton(
           icon: Icon(Icons.save),color: Colors.blue ,onPressed:(){
               widget.viewType==ViewType.saveNote?saveNote(): editNote();
         },),)
        ],
         leading: IconButton(icon: Icon(Icons.arrow_back),
           color: Colors.black ,onPressed: () => Navigator.of(context).pop(),),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.only(right:10,left: 10,top: 20),
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                  hintText: "عنوان الملاحظة",
                ),
              ),
              Divider(height: 20,),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: "وصف ...",
                ),
                minLines: 12,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ],
          ),
        ),
      ),
    );
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _contentController.dispose();
    _subjectController.dispose();
  }


}
