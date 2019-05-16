
import 'package:flutter/material.dart';
class SpiltLine extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      child:  Row(
        children: <Widget>[
           Expanded(child:  Divider(
            height: 10,
            color: Colors.black12
          )
          )
        ],
      ),
    );
  }

}