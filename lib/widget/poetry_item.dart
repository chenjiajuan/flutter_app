import 'package:flutter/material.dart';
import 'package:flutter_app/bo/PoetryBo.dart';

class PoetryItem extends StatefulWidget {
  final Poetry poetry;

  PoetryItem({this.poetry, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    print("createState : ${poetry.authors}");
    return PoetryView(poetry);
  }
}

class PoetryView extends State<PoetryItem> {
  final Poetry poetry;

  PoetryView(this.poetry);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(poetry.title),
            ),
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          ),
          Center(
            child: Text('[${poetry.authors}]'),
          ),
          Container(
            child: Center(
              child: Text(poetry.content, style: TextStyle(fontSize: 16)),
            ),
            margin: EdgeInsets.fromLTRB(5, 0, 0, 15),
          ),
          Divider(
            height: 5,
            color: Colors.blueAccent,
          )
        ],
      ),
    );
  }
}
