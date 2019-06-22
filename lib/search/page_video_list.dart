import 'package:flutter/material.dart';
import 'package:flutter_app/widget/item_video.dart';

class VideoListPage extends StatefulWidget {

//   VideoListPage({Key key}):super(key :key);

  @override
  State<StatefulWidget> createState() {
    return VideoPage();
  }
}

class VideoPage extends State<VideoListPage>  with AutomaticKeepAliveClientMixin{
  List<String> videoList = new List();

  @override
  void initState() {
    super.initState();
    videoList.add('http://cloud.video.taobao.com/play/u/332830327/p/1/e/6/t/1/50086218289.mp4');
    videoList.add('https://cloud.video.taobao.com/play/u/2763096131/p/1/e/6/t/1/50225262418.mp4');
    videoList.add('http://cloud.video.taobao.com/play/u/4050302885/p/1/e/6/t/1/222825658411.mp4');
    videoList.add('http://cloud.video.taobao.com/play/u/4050302885/p/1/e/6/t/1/222825658411.mp4');
    videoList.add('http://cloud.video.taobao.com/play/u/4050302885/p/1/e/6/t/1/222825658411.mp4');
    videoList.add('http://cloud.video.taobao.com/play/u/4050302885/p/1/e/6/t/1/222825658411.mp4');

  }

  @override
  void dispose() {
    super.dispose();
    print('TAG, VideoListPage dispose');
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
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
           child: VideoItem(videoList[i]),
          ));
    }
    return list;
  }

  @override
  bool get wantKeepAlive => true;
}
