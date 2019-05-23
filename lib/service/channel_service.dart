import 'package:flutter/services.dart';
class ChannelService {
   MethodChannel _channel;

  ChannelService(){
    _channel=MethodChannel('native_method_service');
   // _channel.setMethodCallHandler()
  }

   MethodChannel methodChannel(){
    return _channel;
   }

}