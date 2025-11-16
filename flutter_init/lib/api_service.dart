import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_init/models/post.dart';

class ApiService {
  Future<List<Post>> fetchPosts() async {
    final url =
        Uri.parse("https://jsonplaceholder.typicode.com/posts");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
