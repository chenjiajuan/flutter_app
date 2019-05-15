import 'package:flutter/material.dart';
import 'package:flutter_app/widget/item_video.dart';

class VideoListPage extends StatefulWidget {

//   VideoListPage({Key key}):super(key :key);

  @override
  State<StatefulWidget> createState() {
    return VideoPage();
  }
}

class VideoPage extends State<VideoListPage> {
  List<String> videoList = new List();

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
    print('TAG, VideoListPage dispose');
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: 200,
        height: 100,
        child: GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10, //竖向间距
            childAspectRatio: 3/2, //宽高比
            primary: false,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            children: _buildItem2()
    ));
  }



  List<Widget> _buildItem2(){
    List<Widget> list=List();
    for(int i=0;i<videoList.length;i++){
      list.add(new Container(
        color: Colors.blue,
           child: VideoItem(),
          ));
    }
    return list;
  }
}
