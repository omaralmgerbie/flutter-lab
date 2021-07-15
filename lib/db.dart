import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

initillizaeDatabae() async{
  // get the path for our database
  var path = await getDatabasesPath();

  // open my database
  Future<Database> db = openDatabase(join(path,'counters.db'),
      onCreate:(db,version){
        return db.execute('CREATE TABLE COUNTER(ID INTEGER PRIMARY KEY AUTOINCREMENT , VALUE INTEGER )');
      },
      version: 1
  );
  print('database has been created and table has been added');
  return db;
}


