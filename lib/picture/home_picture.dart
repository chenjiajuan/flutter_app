import 'package:flutter/material.dart';

/**
 * 图片的选中，未选中状态
 * 数量的增删改查，
 * 调用相机增加照片
 **/
class HomePicture extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return Picture();
  }



}

class  Picture extends  State<HomePicture>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('图片'),
    );
  }

}