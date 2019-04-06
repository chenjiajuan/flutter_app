import 'package:flutter/material.dart';
class HomeMy extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyPage();
  }

}

class MyPage  extends State<HomeMy>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('我的'),
    );
  }

}