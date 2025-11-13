import 'package:flutter/material.dart';

void main() {
  runApp(
    Text(
      'Hello, Flutter!',
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24, color: Colors.teal),

    ),
  );
}
