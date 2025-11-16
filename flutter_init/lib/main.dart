import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyFirstApp());

class MyFirstApp extends StatefulWidget {
  @override
  _MyFirstAppState createState() => _MyFirstAppState();
}

class _MyFirstAppState extends State<MyFirstApp> {
  bool _loading = false;
  double _progressValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: _loading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LinearProgressIndicator(value: _progressValue),
                      SizedBox(height: 20),
                      Text(
                        '${(_progressValue * 100).round()}%',
                        style: TextStyle(color: Colors.blue, fontSize: 24),
                      ),
                    ],
                  )
                : Text(
                    'Press the button to start download',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _loading ? null : _startDownload,
          child: Icon(Icons.cloud_download),
        ),
      ),
    );
  }

  void _startDownload() {
    setState(() {
      _loading = true;
      _progressValue = 0.0;
    });

    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        _progressValue += 0.05;
        if (_progressValue >= 1.0) {
          _loading = false;
          timer.cancel();
          _progressValue = 0.0;
        }
      });
    });
  }
}
