import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  final String url;

  VideoItem(this.url);

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
  VideoPlayer _videoPlayer;

  @override
  void initState() {
    super.initState();
    listener = () {
      _isPlaying = _videoPlayerController.value.isPlaying;
      print('_listener:_isPlaying : $_isPlaying');

      int currentSeconds = _videoPlayerController.value.position.inSeconds;
      int currentMinutes = _videoPlayerController.value.position.inMinutes;
      if (mounted) {
        setState(() {
          _currentTime =
              currentMinutes.toString() + ":" + currentSeconds.toString();
          _position = (_videoPlayerController.value.position.inMilliseconds /
              _videoPlayerController.value.duration.inMilliseconds);
        });
      }
    };
    _videoPlayerController = VideoPlayerController.network(widget.url)
      ..addListener(listener)
      ..setLooping(true)
      ..initialize().then((_) {
        if (!mounted) return;
        int timeSeconds = _videoPlayerController.value.duration.inSeconds;
        int timeMinutes = _videoPlayerController.value.duration.inMinutes;
        time = timeMinutes.toString() + ":" + timeSeconds.toString();
        if (mounted) {
          setState(() {});
        }
      });
    _videoPlayer = VideoPlayer(_videoPlayerController);
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(listener);
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          SizedBox(
            child: _videoPlayerController.value.initialized
                ? _videoPlayer
                : Container(
                    width: 0,
                    height: 0,
                  ),
            width: double.maxFinite,
            height: 250,
          ),
          Container(
              color: Colors.black26,
              width: double.maxFinite,
              height: 40,
              child:  Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: GestureDetector(
                      child: _iconState(_isPlaying),
                      onTap: () {
                        print('_isPlaying:$_isPlaying');
                        if (_isPlaying) {
                          _videoPlayerController.pause();
                        } else {
                          _videoPlayerController.play();
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      _currentTime,
                      style: new TextStyle(color: Colors.white),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Slider(
                        value: _position,
                        onChanged: (newValue) {},
                        activeColor: Colors.orange,
                        inactiveColor: Colors.white,
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      this.time.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _iconState(bool isPlaying) {
    if (isPlaying) {
      return new Icon(
        Icons.pause,
        color: Colors.white,
      );
    } else {
      return new Icon(
        Icons.play_arrow,
        color: Colors.white,
      );
    }
  }
}
