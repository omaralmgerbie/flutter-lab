import 'package:flutter/material.dart';
import 'localStorage.dart';

class localToShow extends StatefulWidget {
  const localToShow({Key key}) : super(key: key);

  @override
  _localToShowState createState() => _localToShowState();
}


class _localToShowState extends State<localToShow> {

  String _Na="";
  void updateState(String value){

    setState(() {
      this._Na=value;
    });

    }

  @override
  void initState() {
    getString().then((value) => updateState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: ListView(
        children: [Text(_Na),
    Padding(
      padding: EdgeInsets.all(12),
      child: RaisedButton(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),

      ),
      ),
    ),],
      ),
    )
    );
  }
}
