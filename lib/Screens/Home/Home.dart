import 'package:flutter/material.dart';
import 'package:login_ui/Screens/Detail/Detail.dart';
import 'package:login_ui/Screens/Service/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_ui/Screens/Service/news_moudle.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String name;

  @override
  void initState() {
    username();
  }

  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot) {
          if (snapshot.hasData) {
            List<News> news = snapshot.data;
            return ListView(
              children: news
                  .map(
                    (News news) => ListTile(
                      leading: Text(name),
                      title: Text(news.name),
                      subtitle: Text("${news.userId}"),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Detail(
                            news: news,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future username() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString('name');
    });
  }
}
