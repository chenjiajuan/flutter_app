import 'package:http/http.dart' as http;
import 'dart:convert';
class HttpUtil {

   static void get(String url,Function callBack){
     var data;
      http.post(url).then((response){
         if(response.statusCode!=200){
         }else{
           Map<String,dynamic> map=json.decode(response.body);
           data=map["data"];
           print("reponse : "+data.toString());
          callBack(map);
         }
      });

   }


}