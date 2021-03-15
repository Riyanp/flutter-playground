import 'package:dugoy_flutter_playground/src/ui/photo_list.dart';
import 'package:dugoy_flutter_playground/styles/styles.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dugoy flutter apps"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkResponse(
                      enableFeedback: true,
                      onTap: () {
                        Navigator.pushNamed(context, "/photos");
                      },
                      child: ListTile(
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Text("Photo List Example",
                                    style: Styles.largeText),
                              ),
                              Text(
                                  "List of photos example taken from pexels.com using BLOC pattern",
                                  style: Styles.smallText)
                            ]),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
