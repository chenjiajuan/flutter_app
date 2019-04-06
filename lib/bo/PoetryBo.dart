
class PoetryBo{
  int code;
  String message;
  List<Poetry> result;
  PoetryBo(this.code,this.message,this.result);
   PoetryBo.fromJson(Map<String, dynamic> json ){
     code=json["code"];
     message=json["message"];
     result=[];
     int i=0;
     for (var item in json["result"]){
       i++;
       if(i<10){
         result.add(new Poetry.fromJson(item))  ;
       }

     }
   }

}

class Poetry {
  String title;
  String content;
  String authors;
  Poetry(this.title,this.content,this.authors);
  Poetry.fromJson(Map<String,dynamic> json):
    title=json["title"],
    content=json["content"],
    authors=json["authors"];


}