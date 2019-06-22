import 'package:flutter/material.dart';
import 'package:flutter_app/search/home_search.dart';
import 'package:flutter_app/dynamic/home_dynamic.dart';
import 'package:flutter_app/my/home_my.dart';
import 'package:flutter_app/picture/home_picture.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final navigatorKey=GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex=0;
  var listBar=['搞笑','音乐','我的','图片'];
  var _homePage;

  @override
  Widget build(BuildContext context) {
     _homePage=IndexedStack(
       children: <Widget>[HomeSearch(),HomeDynamic(),HomePicture()],
       index: _selectedIndex
     );

    return Scaffold(
      body: _homePage,
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit),title: Text('最新')),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm),title: Text('音乐')),
        BottomNavigationBarItem(icon: Icon(Icons.insert_chart),title: Text('图片')),

      ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
        iconSize: 20,

      )
    );
  }

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;


    });
  }


}


