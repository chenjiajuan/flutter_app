import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/service/navigation_service.dart';
import 'dart:async';

/**
 * 1.flutter页面添加原生组件
 *
 * 2. flutter跳转native
 */
class HomeMy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPage();
  }
}

class MyPage extends State<HomeMy> {
  Map<String, String> creationParams = new Map();
  MethodChannel _channelText;

  @override
  void initState() {
    super.initState();
    creationParams["key"] = '原生组件TextView';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 120,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                  height: 50,
                  width: 40,
                  padding: EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    child: AndroidView(
                      viewType: 'cjj.flutter.io.viewFactory',
                      creationParams: this.creationParams,
                      creationParamsCodec: const StandardMessageCodec(),
                      onPlatformViewCreated: _onPlatformViewCreated(index),
                    ),
                    onDoubleTap: _updateTextView,
                  ));
            },
            itemCount: 2,
          )
        ),
        GestureDetector(
          child: Container(
            height: 50,
            alignment: Alignment.centerLeft,
            child: Text('native2 Activity'),
          ),
          onDoubleTap: _jumpToNativeActivity,
        )
      ],
    );
  }

  _jumpToNativeActivity() {
    print('native Activity');
    NavigationService.openPage('flutter://nativeActivity', {"text":"hello native activity!!"}, false);

  }

  _onPlatformViewCreated(int index) {
    _channelText = MethodChannel('flutter.view.TextView');
  }

  _updateTextView() async {
    await _channelText.invokeMethod('updateTextView', 'hello textview');
  }
}
