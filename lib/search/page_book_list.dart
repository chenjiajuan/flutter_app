import 'package:flutter/material.dart';
import 'package:flutter_app/utils/HttpUtil.dart' as Http;
import 'package:flutter_app/bo/Jokes.dart';
import 'package:flutter_app/widget/split_line.dart';
import 'package:flutter_app/widget/joke_item.dart';
import 'dart:async';

class BooListPage extends StatefulWidget{
  final String keyWord;

  BooListPage(this.keyWord);

  @override
  State<StatefulWidget> createState() {
    return BookPage();
  }

}

class BookPage extends State<BooListPage>{
  List<Joke> jokes=List();
  int currentPage=1;
  ScrollController _controller=ScrollController();
  String url="https://www.apiopen.top/satinGodApi?type=1&page=";

  @override
  void initState() {
    super.initState();
    _initData();
    _controller.addListener((){
      var maxScroll=_controller.position.maxScrollExtent;
      var pixes=_controller.position.pixels;
      print('maxScroll $maxScroll, pixes :$pixes');
      if(maxScroll==pixes){
         _initData();
      }

    });

  }
  @override
  void dispose() {
    super.dispose();
    print('TAG, BookPage dispose');
  }

  @override
  Widget build(BuildContext context) {
    if(jokes==null){
      return new Center(
        child: CircularProgressIndicator(),
      );
    }else{
      Widget listView=ListView.builder(
          itemCount: jokes.length,
          itemBuilder: (context,i)=>buildItem(i),
           controller: _controller,
      );
      return RefreshIndicator(child:  listView, onRefresh: _pullToRefresh);
    }
  }


  Future<Null> _pullToRefresh() async{
    currentPage=1;
      _initData();
    return null;
  }

  void _initData( ) async{
      String url=this.url+currentPage.toString();
      //print('url：'+url);
      Http.HttpUtil.get(url, (data){
        Jokes jokesBo=new Jokes.from(data);
        if(currentPage==1){
          jokes.clear();
        }
        jokes.addAll(jokesBo.data);
       // print(" TAG request jokes : ${jokes.toString()}");
        if(mounted){
          setState(() {

          });
        }
        currentPage++;
      });


  }
  Widget buildItem(int index){
   // print(" TAG buildItem jokes : ${jokes.toString()}");
    if((index+1)%2==0){
      Joke joke=jokes[index];
      return  JokeItem(joke);
    }else{
      return SpiltLine();
    }
  }

}