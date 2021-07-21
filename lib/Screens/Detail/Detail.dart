import 'package:flutter/material.dart';
import 'package:login_ui/Screens/Service/news_moudle.dart';

class Detail extends StatelessWidget {
  final News news;

  Detail({@required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(news.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Name"),
                        subtitle: Text(news.name),
                      ),
                      ListTile(
                        title: Text("ID"),
                        subtitle: Text("${news.id}"),
                      ),
                      ListTile(
                        title: Text("Body"),
                        subtitle: Text(news.body),
                      ),
                      ListTile(
                        title: Text("Email"),
                        subtitle: Text(news.email),
                      ),
                      ListTile(
                        title: Text("User ID"),
                        subtitle: Text("${news.userId}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
