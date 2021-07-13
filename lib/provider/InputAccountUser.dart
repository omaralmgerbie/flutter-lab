
import 'package:flutter/foundation.dart';

class  Users  extends ChangeNotifier{

  String _name , _password , _email ;
  int _phoneNumber;
  var _date;

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  get password => _password;

  set password(value) {
    _password = value;
    notifyListeners();

  }

  get email => _email;

  set email(value) {
    _email = value;
  }

  get date => _date;

  set date(value) {
    _date = value;
  }

  int get phoneNumber => _phoneNumber;

  set phoneNumber(int value) {
    _phoneNumber = value;
  }
}