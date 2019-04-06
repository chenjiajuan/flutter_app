import 'package:flutter/material.dart';
import 'package:flutter_app/bo/Jokes.dart';
class JokeItem extends  StatefulWidget{
  final Joke joke;
  JokeItem(this.joke);

  @override
  State<StatefulWidget> createState() {
    print("create joke： ${joke.username}");
    return new JokeContent(joke);
  }
}

class JokeContent extends State<JokeItem>{
  final Joke joke;
  JokeContent(this.joke);

  @override
  Widget build(BuildContext context) {
    print("item  build :joke ${joke.toString()}");
    return  new Container(
      decoration: new BoxDecoration(
        color: Colors.white
      ),
      width: 300,
      child: new Column(
        children: <Widget>[
          _getHeader(joke),
          _getContent(joke),
          _getComment(joke)
        ],
      ),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
    );
  }
}

 Row _getHeader(Joke joke){
  return new Row(
     children: <Widget>[
       new Container(
         child:new ClipOval(
           child: new Image.network(joke.header),
         ),
         width: 40,
         height: 40,
         margin: new EdgeInsets.fromLTRB(10, 10, 10, 0),
       ),
       new Column(
         children: <Widget>[
           new Text(joke.username),
           new Text(joke.passtime)
         ],
       )
     ],
   );
 }
  Column _getContent(Joke joke){
    return new Column(
      children: <Widget>[
        new Container(
          child: new Text(
            joke.text,
            style: new TextStyle(
              color:Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.left,
            maxLines: 2 ,
          ),
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          alignment: Alignment.centerLeft,
        ),
        new Container(
          child: joke.thumbnail!=null? new Image.network(joke.thumbnail):new Icon(Icons.clear),
          width: double.infinity,
          height: 150,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        )
      ],
    );
  }

  Row _getComment(Joke joke){
    return new Row(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Icon(Icons.thumb_up),
            new Text(joke.up.toString())
          ],
        ),
        new Row(
          children: <Widget>[
            new Icon(Icons.thumb_down),
            new Text(joke.down.toString())
          ],
        ),
        new Row(
          children: <Widget>[
            new Icon(Icons.message),
            new Text(joke.comment.toString())
          ],
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceAround,
//      Max: MainAxisAlignment.spaceAround,
    );
  }




