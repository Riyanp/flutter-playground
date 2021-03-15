import 'package:dugoy_flutter_playground/src/ui/photo_list.dart';
import 'package:flutter/material.dart';

import 'ui/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/home",
      routes: {
        "/home" : (context) => Home(),
        "/photos" : (context) => PhotoList()
      },
      theme: ThemeData.dark(),
      home: Scaffold(
        body: PhotoList(),
      ),
    );
  }
}