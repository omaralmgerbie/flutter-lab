import 'package:flutter/material.dart';
import 'package:login_signup_screen/Service/http_service.dart';
import 'package:login_signup_screen/Service/post_module.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'post_detail.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  String userName ;

  @override
  void initState() {
    getUsername();
  }

  final HttpService httpService = HttpService();

  Future getUsername() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
     
    setState(() {
      userName = sharedPreferences.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data;
            return ListView(
              children: posts
                  .map(
                    (Post post) => ListTile(
                      title: Text(post.title),
                      subtitle: Text("${post.userId}"),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetail(
                            post: post,
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
}
