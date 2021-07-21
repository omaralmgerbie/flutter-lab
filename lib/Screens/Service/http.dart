import 'dart:convert';

import 'package:http/http.dart';
import 'package:login_ui/Screens/Service/news_moudle.dart';

class HttpService {
  final String Url = "https://jsonplaceholder.typicode.com/posts/1/comments";

  Future<List<News>> getPosts() async {
    Response res = await get(Uri.parse(Url));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<News> news = body
          .map(
            (dynamic item) => News.fromJson(item),
          )
          .toList();

      return news;
    } else {
      throw "No News.";
    }
  }
}
