import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;

class Test extends StatefulWidget {
  Future getData() async{
    var url = "https://jsonplaceholder.typicode.com/posts";
    var response = await http.get(url);
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }
  @override
  void initState(){
    getData();
    super.initState();
  }
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: Container(child: Text("page test")),
      ),
    );
  }
}

