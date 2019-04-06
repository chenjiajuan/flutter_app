import 'package:flutter/material.dart';
import 'package:flutter_app/bo/PoetryBo.dart';

class PoetryItem extends StatefulWidget{
 final Poetry poetry;

  PoetryItem(this.poetry);

  @override
  State<StatefulWidget> createState() {
    print("createState : ${poetry.authors}");
    return PoetryView(poetry);
  }

}

class PoetryView extends State<PoetryItem>{
  final Poetry poetry;
  PoetryView(this.poetry);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Center(
              child: new Text(poetry.title),
            ),
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
          ),
          new Center(
            child: new Text('[${poetry.authors}]'),

          ),
          new Container(
            child:new Center(
              child: new Text(poetry.content,
                  style:TextStyle(
                      fontSize: 16
                  )
              ),
            ),
            margin:  EdgeInsets.fromLTRB(5, 0, 0, 15),
          ),

          new Divider(
                height: 5,
                color: Colors.blueAccent,
              )
        ],
      ),
    );
  }

}