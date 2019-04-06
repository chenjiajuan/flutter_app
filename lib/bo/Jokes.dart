

class Jokes{
  int code;
  String msg;
  List<Joke> data;
  Jokes(this.code,this.msg,this.data);

  Jokes.from(Map<String, dynamic> json){
     code=json["code"];
     msg=json["msg"];
     data=[];
     for (var item in json["data"]){
          data.add(new Joke.form(item))  ;
     }
   }

   @override
  String toString() {
    return "$code, $msg , $data";
  }

}

class Joke{
  String username;
  String type;
  String text;
  String header;
  String passtime;
  String video;
  String thumbnail;
  int up;
  int down;
  int comment;
  Joke.form(Map<String,dynamic> joke)
  :username=joke["username"],
        type=joke["type"],
        text=joke["text"],
        header=joke["header"],
        passtime=joke["passtime"],
        video=joke["video"],
        thumbnail=joke["thumbnail"],
        up=joke["up"],
        down=joke["down"],
        comment=joke["comment"];

  @override
  String toString() {
    return "$username, $type ,$text ,$header ,$passtime";
  }
}