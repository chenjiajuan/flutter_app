import 'package:flutter/material.dart';
import 'package:flutter_app/widget/item_video.dart';

class VideoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoPage();
  }
}

class VideoPage extends State<VideoListPage> {
  List<String> videoList=new List();

  @override
  void initState() {
    super.initState();
    videoList.add('1');
    videoList.add('1');
    videoList.add('1');
    videoList.add('1');
    videoList.add('1');
    videoList.add('1');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
        child: GridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 0,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      children: videoList.map((String text){
            return  _buildItem(0);
      }).toList()
    ));
  }

  Widget _buildItem(int index) {
    return new VideoItem();
  }
}
