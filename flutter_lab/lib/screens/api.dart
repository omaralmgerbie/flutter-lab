import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class API extends StatefulWidget {
  @override
  _APIState createState() => _APIState();
}

class _APIState extends State<API> {
  Future<List<Joke>> _getJokes() async {
    var data = await http
        .get(Uri.parse("https://api.chucknorris.io/jokes/search?query=cats"));
    var jsonData = json.decode(data.body);

    List<Joke> jokes = [];

    for (var joke in jsonData["result"]) {
      Joke newJoke = Joke(joke["created_at"], joke["icon_url"], joke["id"],
          joke["url"], joke["value"]);
      jokes.add(newJoke);
    }

    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api Page'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: _getJokes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(snapshot.data[index].iconUrl),
                      ),
                      title: Text(snapshot.data[index].createdAt),
                      subtitle: Text(snapshot.data[index].value),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class Joke {
  final String createdAt;
  final String iconUrl;
  final String id;
  final String url;
  final String value;

  Joke(this.createdAt, this.iconUrl, this.id, this.url, this.value);
}
