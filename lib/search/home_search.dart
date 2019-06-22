import 'package:flutter/material.dart';
import 'package:flutter_app/search/page_book_list.dart';
import 'package:flutter_app/search/page_video_list.dart';
import 'package:flutter_app/search/page_poetry.dart';

class HomeSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchPage();
  }
}

/**
 * AutomaticKeepAliveClientMixin状态页面保存
 */

class SearchPage extends State<HomeSearch> with AutomaticKeepAliveClientMixin {
  final List<Widget> myTabs = <Widget>[
    Tab(text: '热门'),
    Tab(text: '新闻'),
    //https://www.apiopen.top/journalismApi
    Tab(text: '诗词'),
    //https://api.apiopen.top/likePoetry?name=%E6%9D%8E%E7%99%BD
    Tab(text: '搞笑'),
    //https://api.apiopen.top/musicRankingsDetails?type=2
    Tab(text: '短视频')
    //https://api.apiopen.top/todayVideo
  ];
  //数组结合automactic保存页面状态
  List<Widget> _tabViewList = [
    BooListPage(),
    BooListPage(),
    PoetryList(),
    BooListPage(),
    VideoListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
            appBar: AppBar(
              title: TabBar(tabs: myTabs,labelColor: Colors.white,),
            ),
            body: TabBarView(children: _tabViewList)));
  }

  @override
  bool get wantKeepAlive => true;
}
