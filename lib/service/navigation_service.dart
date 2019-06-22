import 'package:flutter_app/service/channel_service.dart';

class NavigationService {
  static final ChannelService _channelService=ChannelService();

  static Future<bool> openPage(String pageName,Map params,bool animated) {
    Map<String,dynamic> properties = new Map<String,dynamic>();
    properties["pageName"]=pageName;
    properties["params"]=params;
    properties["animated"]=animated;
    return _channelService.methodChannel().invokeMethod('openPage',properties).then<bool>((value){
      return (value);
    });
  }
}