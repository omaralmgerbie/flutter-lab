import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:noteapp/NoteFiles/ViewType.dart';
import 'package:noteapp/SomeFunction/singletonClass.dart';
import 'package:noteapp/SomeFunction/someFuns.dart';
import 'ViewNote.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
String _uid;
String color;
  @override
  void initState() {
    super.initState();
      _uid=Singleton.getFireAuthInstace().currentUser.uid;
    getDataFromApi().then((value)
    {
      setState(() {
        color=value;
      });
    }
    );
  }


  @override
  Widget build(BuildContext context) {


    return StreamBuilder (
        stream: FirebaseFirestore.instance .collection('Notes').
        where("UserID",isEqualTo:  _uid).snapshots(),

        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.data==null   ) return Center(child: Text("لا يوجد بيانات للعرض"));

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center( child: CircularProgressIndicator(), );
          }
          if (snapshot.hasError)
            return Center(child:Text("هناك خطاء في النظام يرجاء التواصل مع المسؤول"));

          if (snapshot.hasData && snapshot.data.docs.length > 0 && color!=null)
          return ListView.builder(
           itemCount: snapshot.data.docs.length,
            itemBuilder: (  context,  index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Dismissible(

                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text('حذف العنصر',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),

                    confirmDismiss: (DismissDirection direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              title: const Text("تأكيد الحذف"),
                              content: const Text(
                                  "هل تود حذف هذه الملاحظة ؟"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('Notes')
                                          .doc(snapshot.data.docs[index].id.toString())
                                          .delete()
                                          .then((value) {
                                        print("the record is deleted");
                                      });
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text("حذف")),
                                FlatButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text("إلغاء"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                           tileColor:  Color(int.parse("0xFF$color")) ,
                            onTap: (){
                              Navigator.of(context)
                                  .push(  MaterialPageRoute(builder:
                                  (BuildContext context) =>Note(ViewType.editNote ,
                                postID: snapshot.data.docs[index].id,
                                noteContent: snapshot.data.docs[index]['NoteContent'] ,
                                noteName: snapshot.data.docs[index]['NoteName'] ,)));

                            },// end onTap,

                            leading: Icon( Icons.note , size: 50 ,color: Colors.blue,),
                            title: Text(snapshot.data.docs[index]['NoteName'] ,style: TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(snapshot.data.docs[index]['NoteContent']),
                          ),

                        ),
                        Divider(color: Colors.grey,)
                      ],
                    ),
                  ),
                );


            },
          );
          else return Center( child: Text("لا يوجد بيانات للعرض"), );
        });

  }
}
