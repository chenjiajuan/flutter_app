import 'dart:math';
import 'dart:ui';

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

class DynamicPage extends State<HomeDynamic> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  List<Music> _musicList = List();
  int _position = 0;
  String musicName = '';
  String musicAuthor = '';
  final _cdRotateTween = new Tween<double>(begin: 0.0, end: 1.0); //动画参数
  AnimationController _controllerRecord; //动画控制器
  Animation<double> _animationRecord;
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  AnimationController _controllerNeedle;
  Animation<double> _animationNeedle;
  Function _listenerRecord;
  Function _listenerNeedle;
  String coverArt =
      'https://pics2.baidu.com/feed/4b90f603738da9779e9191a43c124a1d8718e34f.jpeg?token=3753e411020d1cf52b3b949e2cfe6216&amp;s=6DC87A23DAF33BAD3597855F0100C0E0';

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 2),
        child: Stack(
          children: <Widget>[
            Container(
                child: new BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Opacity(
                opacity: 0.6,
                child: new Container(
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            )),
            Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Text(
                          musicName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.normal),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            musicAuthor,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontStyle: FontStyle.normal),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                          child: Container(
                            width: 270,
                            height: 270,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white10),
                          )),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(coverArt),
                                    fit: BoxFit.cover)),
                          )),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 115, 0, 0),
                        alignment: Alignment.center,
                        child: _getCDWidget(),
                      ),
                      Container(
                        child: PivotTransition(
                            turns: _rotateTween.animate(_controllerNeedle),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                              child: SizedBox(
                                  width: 100,
                                  height: 200,
                                  child: Image.asset('images/play_needle.png')),
                            )),
                      )
                    ],
                  ),
                ),
                PlayerMusic(
                  musicList: _musicList,
                  onComplete: () {},
                  lastMusic: (position) {
                    print('lastMusic');
                    nameAndAuthor(position);
                  },
                  nextMusic: (position) {
                    print('nextMusic');
                    nameAndAuthor(position);
                  },
                  startPlay: () {
                    _controllerRecord.forward();
                    _controllerNeedle.forward();
                  },
                  pausePlay: () {
                    _controllerRecord.stop(canceled: false);
                    _controllerNeedle.reset();
                  },
                  stopPlay: () {
                    _controllerRecord.stop(canceled: false);
                    _controllerNeedle.reset();
                  },
                  resumePlay: (){
                    _controllerRecord.forward();
                    _controllerNeedle.forward();
                  },
                )
              ],
            ),
          ],
        ));
  }

  @override
  void deactivate() {
    _controllerRecord.stop(canceled: true);
    _controllerNeedle.stop(canceled: true);
    super.deactivate();
  }

  @override
  void dispose() {
    _animationRecord.removeListener(_listenerRecord);
    _animationNeedle.removeListener(_listenerNeedle);
    _controllerRecord.dispose();
    _controllerNeedle.dispose();
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
        duration: const Duration(milliseconds: 15000), vsync: this);
    //动画监听，每次旋转完成后继续旋转
    _animationRecord =
        CurvedAnimation(parent: _controllerRecord, curve: Curves.linear);
    _listenerRecord = (status) {
      if (status == AnimationStatus.completed) {
        _controllerRecord.repeat();
      } else if (status == AnimationStatus.dismissed) {
        _controllerRecord.forward();
      }
    };
    _animationRecord.addStatusListener(_listenerRecord);
    _controllerNeedle = AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _animationNeedle =
        CurvedAnimation(parent: _controllerRecord, curve: Curves.linear);
    _listenerNeedle = () {};
    _animationNeedle.addListener(_listenerNeedle);

    nameAndAuthor(_position);
  }

  nameAndAuthor(int position) {
    setState(() {
      musicName = _musicList[position].name;
      musicAuthor = _musicList[position].author;
    });
  }

  Widget _getCDWidget() {
    return new Container(
      width: 200,
      height: 200,
      child: RotationTransition(
          turns: _cdRotateTween.animate(_controllerRecord),
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(coverArt), fit: BoxFit.cover)))),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
