import 'package:flutter/material.dart';
import 'package:flutter_app/search/page_book_list.dart';
import 'package:flutter_app/search/page_video_list.dart';

 class HomeSearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SearchPage();
  }

 }

 class SearchPage  extends State<HomeSearch>{
   final List<Tab> myTabs=<Tab>[
     Tab(text: '段子'),
     Tab(text: '新闻'), //https://www.apiopen.top/journalismApi
     Tab(text: '诗词'), //https://api.apiopen.top/likePoetry?name=%E6%9D%8E%E7%99%BD
     Tab(text: '音乐'), //https://api.apiopen.top/musicRankingsDetails?type=2
     Tab(text: '短视频') //https://api.apiopen.top/todayVideo
   ];

  @override
  Widget build(BuildContext context) {
    return  new DefaultTabController(
        length:myTabs.length,
        child: new Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: myTabs),
          ),
          body: TabBarView(
              children:myTabs.map((dynamic item ){
                if(item.text=='短视频'){
                  return new VideoListPage();
                }else{
                  return new BooListPage(item.text);
                }
              }) .toList(),
        )

        ));
  }

 }
