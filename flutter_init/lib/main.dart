import 'package:flutter/material.dart';
import 'package:flutter_init/posts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
