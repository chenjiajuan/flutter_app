import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoContent();
  }
}

class VideoContent extends State<VideoItem> {
  VideoPlayerController _videoPlayerController;
  String _currentTime = "0:00";
  double _position = 0.0;
  bool _isPlaying = false;
  String time = "0:00";
  VoidCallback listener;
  AnimationController _animationController;
  static final _tween=Tween<double>(begin: 0.0,end: 1.0);
  VoidCallback animationListener;


  @override
  void initState() {
    super.initState();
    listener = () {
      if(!mounted){
        return;
      }
      _animationController=AnimationController(vsync: null,
          duration: Duration(seconds: 1),

      );
      animationListener=(){
         setState(() {

         });
      };
      
      _isPlaying = _videoPlayerController.value.isPlaying;
      int currentSeconds = _videoPlayerController.value.position.inSeconds;
      int currentMinutes = _videoPlayerController.value.position.inMinutes;
      if (mounted) {
         setState(() {
           _currentTime=currentMinutes.toString()+":"+currentSeconds.toString();
           _position=(_videoPlayerController.value.position.inMilliseconds/_videoPlayerController.value.duration.inMilliseconds);

         });
      }
    };
    _videoPlayerController = VideoPlayerController.network(
        "https://cloud.video.taobao.com/play/u/2763096131/p/1/e/6/t/1/50225262418.mp4")
      ..addListener(listener)
      ..setLooping(true)
      ..initialize().then((_) {
        if(!mounted)
          return;
        int timeSeconds = _videoPlayerController.value.duration.inSeconds;
        int timeMinutes = _videoPlayerController.value.duration.inMinutes;
        time = timeMinutes.toString() + ":" + timeSeconds.toString();
        if(mounted){
          setState(() {
          });
        }

      });

  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(listener);
    _videoPlayerController.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 250,
      color: Colors.orange,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          new SizedBox(
            child: _videoPlayerController.value.initialized
                ? new VideoPlayer(_videoPlayerController)
                : new Container(),
            width: double.maxFinite,
            height: 250,
          ),
          new Container(
              color: Colors.black26,
              width: double.maxFinite,
              height: 40,
              child:Opacity(
                  child: new Row(
                    children: <Widget>[
                      new Container(  //图片
                        margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
                        child: new GestureDetector(
                          child: _iconState(_isPlaying),
                          onTap: () {
                            if (_isPlaying) {
                              _videoPlayerController.pause();
                            } else {
                              _videoPlayerController.play();
                            }
                          },
                        ),
                      ),
                      new Container(  //当前时间
                        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: new Text(
                          _currentTime,
                          style: new TextStyle(color: Colors.white),
                        ),
                      ),
                      new Container(  //进度条
                          width: 250,
                          height: 4,
                          child: new LinearProgressIndicator(
                            backgroundColor: Colors.white,
                            value: _position,
                            valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.orange),
                          )),
                      new Container(  //时间
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: new Text(
                          this.time.toString(),
                          style: new TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ))

               )


        ],
      ),
    );
  }

  Widget _iconState(bool isPlaying) {
    if (isPlaying) {
      return new Icon(Icons.play_arrow);
    } else {
      return new Icon(Icons.pause);
    }
  }


}
