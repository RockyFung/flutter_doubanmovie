import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/hot/HotMovieData.dart';
import 'package:flutter_doubanmovie/hot/HotMovieItemWidget.dart';
import 'package:http/http.dart' as http;

class HotMoviesListWidget extends StatefulWidget{
  
  String curCity;
  HotMoviesListWidget(String city){
    curCity = city;
  }

  @override
  State<StatefulWidget> createState() {

    return HotMoviesListWidgetState();
  }
}

class HotMoviesListWidgetState extends State<HotMoviesListWidget> with AutomaticKeepAliveClientMixin{
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true; //返回 true，表示不会被回收
  // 数据容器
  List<HotMovieData> hotMovies = new List<HotMovieData>();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData()async{
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city='+widget.curCity+'&start=0&count=10&client=&udid=');
    //成功获取数据
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      setState(() {
        hotMovies = serverDataList;
      });
    } 
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (hotMovies == null || hotMovies.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.separated(
      itemCount: hotMovies.length,
      itemBuilder: (context, index){
        return HotMovieItemWidget(hotMovies[index]);
      },
      separatorBuilder: (context, index){
        return Divider(
          height: 1,
          color: Colors.black26,
        );
      },
    );
    }
    
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void didUpdateWidget(HotMoviesListWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
}