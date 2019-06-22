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


   static void get2(String url,Function callBack){
     http.get(url).then((response){
       print('response :'+response.toString());
       if(response.statusCode!=200){
       }else{
         Map<String,dynamic> map=json.decode(response.body);
         print("map : "+map.toString());
         callBack(map);
       }
     });

   }

   static void _getHttpData(){
    // var httpClent=HttpClient()
   }

}