
import 'package:flutter/material.dart';
class SpiltLine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        children: <Widget>[
          new Expanded(child: new Divider(
            height: 10,
            color: Colors.black12
          )
          )
        ],
      ),
    );
  }

}