import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bo/music.dart';
import 'package:flutter_app/widget/player_music.dart';

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
  String musicName='';
  String musicAuthor='';
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
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Stack(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'http://simg.sinajs.cn/blog7style/images/blog_editor/ten_map.png'),
                              fit: BoxFit.cover)),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
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
          PlayerMusic(
            musicList: _musicList,
            onComplete: (){},
            lastMusic:(position){ print('lastMusic');nameAndAuthor(position);},
            nextMusic: (position){print('nextMusic');nameAndAuthor(position);},
            startPlay: (){ _controllerRecord.forward();},
            pausePlay: (){ _controllerRecord.stop(canceled: false);},
            stopPlay: (){ _controllerRecord.stop(canceled: false);},
          )


        ],
      ),
    );
  }

  @override
  void deactivate() {
    _controllerRecord.stop(canceled: true);
    super.deactivate();
  }

  @override
  void dispose() {
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

    nameAndAuthor(_position);
  }


  nameAndAuthor(int position){
    setState(() {
      musicName=_musicList[position].name;
      musicAuthor=_musicList[position].author;
    });

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
