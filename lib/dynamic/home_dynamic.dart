import 'package:flutter/material.dart';
class HomeDynamic extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DynamicPage();
  }

}

class DynamicPage  extends State<HomeDynamic>{
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Text('测试')
    );
  }

}