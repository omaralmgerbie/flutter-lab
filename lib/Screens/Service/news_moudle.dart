import 'package:flutter/foundation.dart';

class News {
  final int userId;
  final int id;
  final String name;
  final String email;
  final String body;

  News({
    @required this.userId,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.body,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      userId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}