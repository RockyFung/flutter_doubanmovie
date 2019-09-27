import 'package:flutter/material.dart';

class HotWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotWidgetState();
  }
}

class HotWidgetState extends State<HotWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: <Widget>[
              //  搜索页面
            Text('上海',style: TextStyle(fontSize: 16),),
            Icon(Icons.arrow_drop_down),
            Expanded(
              flex: 1,
              child: TextField(
                textAlign: TextAlign.center,
                style:TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: '\uE8b6 电影/电视剧/影人',
                  hintStyle: TextStyle(fontFamily: 'MaterialIcons',fontSize: 16),
                  contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.black12
                ),
              ),
            ),
          
        ],),
        ),

       // tab页面
      Expanded(
        flex: 1,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: <Widget>[
              // tab按钮
              Container(
                constraints: BoxConstraints.expand(height: 50),
                child: TabBar(
                  unselectedLabelColor: Colors.black12,
                  labelColor: Colors.black87,
                  indicatorColor: Colors.black87,
                  tabs: <Widget>[Tab(text: '正在热映'),Tab(text: '即将上映',)],
                )
              ),
              // tab页面
              Expanded(
                child: Container(
                  child: TabBarView(children: <Widget>[
                    Center(child: Text('正在热映'),),
                    Center(child: Text('即将上映'),)
                  ],),),
              )
            ],
          ),
        ),
      )
    ],)
    );
  }
}