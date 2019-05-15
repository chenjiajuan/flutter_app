import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bo/music.dart';
class HomeDynamic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DynamicPage();
  }
}
class DynamicPage extends State<HomeDynamic>  with TickerProviderStateMixin{
  List<Music> _musicList = List();
  int _position = 0;
  AudioPlayer _audioPlayer = AudioPlayer();
  int totalDuration = 0;
  double sliderValue = 0;
  String totalTime = '';
  String nowTime = '';
  Duration _duration;
  String musicName='';
  String musicAuthor='';
  AudioPlayerState _audioPlayerState;
  final _cdRotateTween = new Tween<double>(begin: 0.0, end: 1.0); //动画参数
  AnimationController  _controllerRecord ; //动画控制器
  Animation<double> _animationRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(musicName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontStyle: FontStyle.normal),
                ),
                Text(musicAuthor,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal),
                ),
              ],
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 75, 0, 0),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(125),
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://simg.sinajs.cn/blog7style/images/blog_editor/ten_map.png'),
                              fit: BoxFit.cover)),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  alignment: Alignment.center,
                  child: _getCDWidget(),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                  child: SizedBox(
                      width: 100,
                      height: 200,
                      child: Image.asset('images/play_needle.png')),
                )
              ],
            ),
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nowTime,
                      style: TextStyle(color: Colors.white24),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(//进度条
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    height: 4,
                    child: Slider(
                      onChanged: (newValue) {
                        int seconds = (_duration.inSeconds * newValue).round();
                         print("audioPlayer.seek: $seconds");
                         _audioPlayer.seek(new Duration(seconds: seconds));
                      },
                      value: sliderValue,
                      activeColor: Colors.white54,
                      inactiveColor: Colors.white24,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      totalTime,
                      style: TextStyle(color: Colors.white24),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            alignment: Alignment.center,
            child: Container(
                width: 100,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: lastMusic,
                      child: Icon(Icons.first_page),
                    ),
                    GestureDetector(
                      child: Icon(Icons.stop),
                      onTap: audioState,
                    ),
                    GestureDetector(
                      onTap: nextMusic,
                      child: Icon(Icons.last_page),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    _audioPlayer.stop();
    _controllerRecord.stop(canceled: true);
    super.deactivate();
  }

  @override
  void dispose() {
    _audioPlayer.release();
    _controllerRecord.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Music music = Music('归去来兮', 'http://www.ytmp3.cn/down/73267.mp3', '花粥');
    Music music2 = Music('出山', 'http://www.ytmp3.cn/down/57880.mp3', '花粥&王胜男');
    Music music3 = Music('盗将行', 'http://www.ytmp3.cn/down/48303.mp3', '花粥&马雨阳');
    Music music4 = Music('归去来兮', 'http://www.ytmp3.cn/down/73214.mp3', '叶炫清');
    _musicList.add(music);
    _musicList.add(music2);
    _musicList.add(music3);
    _musicList.add(music4);
   // AudioPlayer.logEnabled = true;
    //唱片旋转
   _controllerRecord = new AnimationController(
    duration: const Duration(milliseconds: 15000),vsync:this);
   //动画监听，每次旋转完成后继续旋转
    _animationRecord=CurvedAnimation(parent: _controllerRecord, curve: Curves.linear);

    _animationRecord.addStatusListener((status){
      if (status == AnimationStatus.completed) {
         _controllerRecord.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controllerRecord.forward();
      }
    });

    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        this._duration = duration;
        totalDuration = duration.inMilliseconds;
        totalTime = _formatDuration(duration);
      });
    });
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      //print('onAudioPosition : ${duration.inMilliseconds}');
      setState(() {
        sliderValue = duration.inMilliseconds / totalDuration;
        if(sliderValue>1.0){
          sliderValue=1.0;
        }
        nowTime = _formatDuration(duration);
      });
      // print('onAudioPosition , sliderValue: $sliderValue , totalTime:$totalTime');
    });
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      this._audioPlayerState=s;
      if(s==AudioPlayerState.COMPLETED){
         nextMusic();
      }
      //print('onPlayStateChange $s');
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      print('onPlayerCompletion');
       nextMusic();
    });
    nameAndAuthor();
  }

  lastMusic() {
    if (_position == 0) {
      return;
    }
    _position -=1;
    playAudio();
    nameAndAuthor();
  }

  nextMusic() {
    if (_position == _musicList.length - 1) {
      _position = 0;
    } else {
      _position += 1;
    }

    playAudio();
    nameAndAuthor();

  }

  nameAndAuthor(){
    setState(() {
      musicName=_musicList[_position].name;
      musicAuthor=_musicList[_position].author;
    });

  }

  playAudio() async {
    _audioPlayer.release();
    int result =
        await _audioPlayer.play(_musicList[_position].url, volume: 1.0);
    if (result == 1) {
      print('play url');
    }
    _controllerRecord.forward();
  }

  stopAudio() async {
    int result = await _audioPlayer.stop();
    if (result == 1) {
      print('stop Audio');
    }
    _controllerRecord.stop(canceled: false);
  }

  pauseAudio() async{
    int result=await _audioPlayer.pause();
    if(result==1){
      print('play is pause');
    }
    _controllerRecord.stop(canceled: false);
  }

  resumeAudio() async{
    int result=await _audioPlayer.resume();
    if(result==1){
      print('play is resume');
    }
  }
  audioState() {
    print('onTop');
    playAudio();
    if(_audioPlayerState==AudioPlayerState.PLAYING){
      pauseAudio();
    }else if(_audioPlayerState==AudioPlayerState.PAUSED){
      resumeAudio();
    }
  }


  String _formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    //print(d.inMinutes.toString() + "======" + d.inSeconds.toString());
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }

  Widget _getCDWidget() {
    return new Container(
      width: 200,
      height: 200,
      child:RotationTransition(
         turns: _cdRotateTween.animate(_controllerRecord),
           child: Container(
               decoration: BoxDecoration(
                   shape: BoxShape.circle,
                   image: DecorationImage(
                       image: NetworkImage(
                           'http://simg.sinajs.cn/blog7style/images/blog_editor/ten_map.png'),
                       fit: BoxFit.cover))
           )
        ),
    );
  }
}



//动画包装类
class PivotTransition extends AnimatedWidget {
  final FractionalOffset alignment;
  final Widget child;

  PivotTransition({
    Key key,
    this.alignment: FractionalOffset.topCenter,
    @required Animation<double> turns,
    this.child,
  }) : super(key: key, listenable: turns);

  Animation<double> get turns => listenable;

  @override
  Widget build(BuildContext context) {
    final double transValue = turns.value;
    final Matrix4 matrix4 = Matrix4.rotationZ(transValue * pi * 2.0);

    return Transform(
      transform: matrix4,
      alignment: alignment,
      child: child,
    );
  }
}
