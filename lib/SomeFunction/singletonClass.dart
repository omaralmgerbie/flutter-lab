import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Singleton {
  Singleton._();

  //
  static FirebaseAuth _uniqueInstance;
  static SharedPreferences _pref;
  static   FirebaseFirestore _fireStoreInstance ;

  static FirebaseAuth getFireAuthInstace() {
    if (_uniqueInstance == null) {
      _uniqueInstance = FirebaseAuth.instance;
    }
    return _uniqueInstance;
  }

  static Future<SharedPreferences> getPrefInstace() async {
    if (_pref == null) {
      _pref = await SharedPreferences.getInstance();
    }
    return _pref;
  }
  static FirebaseFirestore  getFireStoreInstance()   {
    if (_fireStoreInstance == null) {
      _fireStoreInstance = FirebaseFirestore.instance;
    }
    return _fireStoreInstance;
  }
}
