import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_itmc323/DataType/Users.dart';




FirebaseFirestore firestore = FirebaseFirestore.instance;
final String collection = 'users';
final firebase = FirebaseAuth.instance;


getData(var email,var password) async
{

  print("ay");
  Users user = Users();
  DocumentSnapshot ds = await firestore
      .collection("users")
      .doc(email)
      .get();
  if (ds.exists) {
    if (ds['password'] == password) {
      user.name = ds['name'] ?? '';
    }
    print("done");
  }
}

class Firebase{

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future signin() async {
    try {
      UserCredential auth = await firebaseAuth.signInAnonymously();
      var user = auth.user;
      return user;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}