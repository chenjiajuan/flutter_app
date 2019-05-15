import 'package:flutter/material.dart';
import 'package:flutter_app/bo/music.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayerMusic extends StatefulWidget {
  final List<Music> musicList;
  final Function() onComplete;
  final Function(int) lastMusic;
  final Function(int) nextMusic;
  final Function() startPlay;
  final Function() stopPlay;
  final Function() pausePlay;
  final Function() resumePlay;

  PlayerMusic(
      {@required this.musicList,
      @required this.onComplete,
      @required this.lastMusic,
      @required this.nextMusic,
      @required this.startPlay,
      @required this.pausePlay,
      @required this.stopPlay,
      @required this.resumePlay});

  @override
  State<StatefulWidget> createState() {
    return PlayerState();
  }
}

class PlayerState extends State<PlayerMusic> {
  String totalTime = '0:00';
  String nowTime = '0:00';
  int _position = 0;
  Duration _duration;
  int totalDuration = 0;
  AudioPlayer _audioPlayer = AudioPlayer();
  double sliderValue = 0;
  AudioPlayerState _audioPlayerState = AudioPlayerState.COMPLETED;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        this._duration = duration;
        totalDuration = duration.inMilliseconds;
        totalTime = _formatDuration(duration);
      });
    });
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        sliderValue = duration.inMilliseconds / totalDuration;
        if (sliderValue > 1.0) {
          sliderValue = 1.0;
        }
        nowTime = _formatDuration(duration);
      });
    });
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      this._audioPlayerState = s;
      if (s == AudioPlayerState.COMPLETED) {
        nextMusic();
      }
      if (s == AudioPlayerState.PLAYING) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      setState(() {});
      print('onPlayerStateChanged : $_audioPlayerState $_isPlaying');
    });
    _audioPlayer.onPlayerCompletion.listen((event) {
      nextMusic();
    });
  }

  @override
  void deactivate() {
    _audioPlayer.stop();
    super.deactivate();
  }

  @override
  void dispose() {
    _audioPlayer.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
         child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 50,
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      nowTime,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    height: 4,
                    child: Slider(
                      onChanged: (newValue) {
                        int seconds = (_duration.inSeconds * newValue).round();
                        _audioPlayer.seek(new Duration(seconds: seconds));
                      },
                      value: sliderValue,
                      activeColor: Colors.white70,
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
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    onTap: lastMusic,
                    child: Icon(Icons.skip_previous,
                        size: 32, color: Colors.white),
                  ),
                ),
                Container(
                  width: 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 32, color: Colors.white),
                    onTap: audioState,
                  ),
                ),
                Container(
                  width: 50,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: GestureDetector(
                    onTap: nextMusic,
                    child: Icon(Icons.skip_next, size: 32, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      ),
    );
  }

  lastMusic() {
    if (_position == 0) {
      return;
    }
    _position -= 1;
    playAudio();
    widget.lastMusic(_position);
    //nameAndAuthor();
  }

  nextMusic() {
    if (_position == widget.musicList.length - 1) {
      _position = 0;
    } else {
      _position += 1;
    }

    playAudio();
    widget.nextMusic(_position);
    //nameAndAuthor();
  }

  playAudio() async {
    _audioPlayer.release();
    int result =
        await _audioPlayer.play(widget.musicList[_position].url, volume: 1.0);
    if (result == 1) {
      print('play url');
    }
    widget.startPlay();
  }

  stopAudio() async {
    int result = await _audioPlayer.stop();
    if (result == 1) {
      print('stop Audio');
    }
    widget.stopPlay();
  }

  pauseAudio() async {
    int result = await _audioPlayer.pause();
    if (result == 1) {
      print('play is pause');
    }
    widget.pausePlay();
  }

  resumeAudio() async {
    int result = await _audioPlayer.resume();
    if (result == 1) {
      print('play is resume');
    }
    widget.resumePlay();
  }

  audioState() {
    print('onTop : $_audioPlayerState');
    if (_audioPlayerState == AudioPlayerState.PLAYING) {
      pauseAudio();
    } else if (_audioPlayerState == AudioPlayerState.PAUSED) {
      resumeAudio();
    } else if (_audioPlayerState == AudioPlayerState.COMPLETED) {
      playAudio();
    }
  }

  String _formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }
}
