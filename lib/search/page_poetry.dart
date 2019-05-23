import 'package:flutter/material.dart';
import 'package:flutter_app/utils/HttpUtil.dart';
import 'package:flutter_app/bo/PoetryBo.dart';
import 'package:flutter_app/widget/poetry_item.dart';

class PoetryList extends StatefulWidget {
  PoetryList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PoetryState();
  }
}

class PoetryState extends State<PoetryList> {
  List<Poetry> list = List();
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    print('TAG, PoetryList dispose');
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: double.infinity,
      child: new Column(
        children: <Widget>[
          new Container(
            child: new TextField(
              decoration: new InputDecoration(
                suffixIcon: new Icon(Icons.search),
                hintText: '请输入诗词相关字',
              ),
              keyboardType: TextInputType.text,
              onSubmitted: _submitted,
              onChanged: _searchData,
              autofocus: false,
            ),
            height: 40,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
          ),
          new Text(textEditingController.text),
          new Expanded(
            child: new ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) => buildItem(list[i], ValueKey(i))),
          ),
        ],
      ),
    );
  }

  void _searchData(String text) {
    print('$text');
  }

  void _submitted(String text) {
    print('_submitted ,$text');
  }

  void _initData() async {
    HttpUtil.get2('https://api.apiopen.top/likePoetry?name=李白', (data) {
      PoetryBo poetryList = new PoetryBo.fromJson(data);
      list.addAll(poetryList.result);
      if (mounted) {
        setState(() {});
      }
     // print('list : ${list.length}');
    });
  }

  PoetryItem buildItem(Poetry poetry, Key i) {
   // print("buildItem  poetry : ${poetry.authors}");
    return PoetryItem(poetry: poetry, key: i);
  }
}
