import 'package:flutter/material.dart';
import 'package:flutter_app/search/home_search.dart';
import 'package:flutter_app/dynamic/home_dynamic.dart';
import 'package:flutter_app/my/home_my.dart';

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
  var listBar=['最新','动态','我的'];
  var _homePage;

  @override
  Widget build(BuildContext context) {
     _homePage=IndexedStack(
       children: <Widget>[HomeSearch(),HomeDynamic(),HomeMy()],
       index: _selectedIndex
     );

    return Scaffold(
      appBar: AppBar(
       title: Text(
         listBar[_selectedIndex]
       ),
      ),
      body: _homePage,
      bottomNavigationBar: BottomNavigationBar(items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.ac_unit),title: Text('最新')),
        BottomNavigationBarItem(icon: Icon(Icons.access_alarm),title: Text('动态')),
        BottomNavigationBarItem(icon: Icon(Icons.insert_chart),title: Text('我的'))
      ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
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


