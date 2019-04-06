import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return VideoContent();
  }
 }

 class VideoContent  extends State<VideoItem>{
   VideoPlayerController _videoPlayerController;
   String _currentTime="0:00";
   double _position=0.0;
   bool _isPlaying=false;
   String time="0:00";

   @override
   void initState() {
     super.initState();
     _videoPlayerController=VideoPlayerController.network("https://cloud.video.taobao.com/play/u/2763096131/p/1/e/6/t/1/50225262418.mp4")
       ..initialize().then((_){
         int timeSeconds=_videoPlayerController.value.duration.inSeconds;
         int timeMinutes=_videoPlayerController.value.duration.inMinutes;
         time=timeMinutes.toString()+":"+timeSeconds.toString();
         setState(() {

         });
       })
       ..setLooping(true)
       ..addListener((){
           _isPlaying=_videoPlayerController.value.isPlaying;
           int currentSeconds= _videoPlayerController.value.position.inSeconds;
           int currentMinutes=_videoPlayerController.value.position.inMinutes;
           setState(() {
             _currentTime=currentMinutes.toString()+":"+currentSeconds.toString();
             _position=(_videoPlayerController.value.position.inMilliseconds/_videoPlayerController.value.duration.inMilliseconds);

           });


       });

   }
   @override
   void dispose() {
     super.dispose();
     _videoPlayerController.dispose();
   }
   @override
   Widget build(BuildContext context) {
     return new Container(
       height: 250,
       width: double.maxFinite,
       color: Colors.orange,
       child: new Column(
         children: <Widget>[
           new Stack(
             alignment: Alignment.bottomCenter,
             children: <Widget>[
               new SizedBox(
                 child: _videoPlayerController.value.initialized?
                   new VideoPlayer(_videoPlayerController)
                 :new  Container(),
                 width:double.maxFinite ,
                 height:200,
               ),
               new Container(
                   color: Colors.black26,
                   width: double.maxFinite,
                   height: 40,
                   child: new Row(
                     children: <Widget>[
                       new Container(
                         margin: EdgeInsets.fromLTRB(20, 0, 5,0),
                         child: new GestureDetector(
                           child: _iconState(_isPlaying),
                           onTap: (){
                             if(_isPlaying){
                               _videoPlayerController.pause();
                             }else{
                               _videoPlayerController.play();
                             }
                           },
                         ),
                       ),
                       new Container(
                         margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                         child: new Text(_currentTime,
                           style: new TextStyle(
                               color: Colors.white
                           ),
                         ),
                       ),
                       new Container(
                           width: 250,
                           height: 4,
                           child:new LinearProgressIndicator(
                             backgroundColor: Colors.white,
                             value: _position,
                             valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                           )
                       ),
                       new Container(
                         margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                         child: new Text(this.time.toString(),
                           style: new TextStyle(
                               color: Colors.white
                           ),
                         ),
                       )

                     ],
                   )
               )
             ],

           ),

         ],
       ),
     );
   }
   Widget _iconState(bool isPlaying){
     if(isPlaying){
       return new Icon(Icons.play_arrow);
     }else{
       return new Icon(Icons.pause);
     }
   }
 }