import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:lab_project/utils/EnviromentConfig.dart';

var token = "";
var searchQuery = "Cat";
FirebaseFirestore? firestore;
CollectionReference? favList;
List<String> favIds = <String>[];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    //print("completed");
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      FirebaseAuth auth = FirebaseAuth.instance;
      firestore = FirebaseFirestore.instance;

      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          FirebaseAuth.instance.signInAnonymously();
        } else {
          print('User is signed in!');
          token = user.uid;
          favList = firestore?.collection(token);
          print('id = $token');
          favList?.snapshots().listen((event) {
            favIds.clear();
            event.docs.forEach((element) {
              print("elemnent id = ${element.id}");
              favIds.add(element.id);
              print("list = $favIds");
            });
          });
        }
      });
    });

    return MaterialApp(
      title: 'CAT!',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late SearchBar searchBar;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildDefaultAppBar(BuildContext context) {
    return new AppBar(
        title: new Text(searchQuery),
        actions: [searchBar.getSearchAction(context)]);
  }

  _MyHomePageState() {
    searchBar = new SearchBar(
        setState: setState,
        buildDefaultAppBar: buildDefaultAppBar,
        onSubmitted: (query) {
          searchQuery = query;
          fetchImages();
        });
  }

  fetchImages() async {
    //fetch data from api and cache ..
    var file = await DefaultCacheManager().getSingleFile(
        "https://api.unsplash.com/search/photos?client_id=${EnvironmentConfig.CLIENT_ID}&query=$searchQuery");
    var res = await file.readAsString();
    var data = jsonDecode(res)['results'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: FutureBuilder(
        future: fetchImages(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Check your internet connection and try again.",
                      style: TextStyle(color: Colors.white),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        fetchImages();
                        setState(() {});
                      },
                      child: Text("Try Again"),
                    )
                  ]),
            );
          }
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                placeholder: (context, url) => Center(
                                  child: SizedBox(
                                    child: CircularProgressIndicator(),
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                imageUrl: snapshot.data[index]['urls']
                                    ['regular'],
                                height: 180,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    (favIds.contains(
                                                snapshot.data[index]['id']) ==
                                            false)
                                        ? favList
                                            ?.doc(snapshot.data[index]['id'])
                                            .set({
                                            'id': snapshot.data[index]['id']
                                          })
                                        : favList
                                            ?.doc(snapshot.data[index]['id'])
                                            .delete();
                                    setState(() {});
                                  },
                                  child: Center(
                                      child: Icon(
                                    (favIds.contains(
                                                snapshot.data[index]['id']) ==
                                            true)
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    size: 16,
                                    color: Colors.black,
                                  )),
                                ),
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data[index]['description'] ??
                                        snapshot.data[index]
                                            ['alt_description'] ??
                                        "",
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                });
          }
          if (snapshot.data.length == 0) {
            return Center(
              child: Text(
                "No results found :(",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
