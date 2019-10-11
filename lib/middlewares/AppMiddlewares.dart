import 'package:flutter_doubanmovie/action/AppActions.dart';
import 'package:flutter_doubanmovie/state/AppState.dart';
import 'package:flutter_doubanmovie/ui/hot/HotMovieData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void appMiddlewares(Store<AppState> store, Object action, NextDispatcher next){
  if (action is InitAction) {
    // 初始化数据
    initCity(store);
  } else if(action is ChangeCityAction){
    // 改变城市重新获取电影数据
    getData(store, action);
  }
  next(action);
}

// 初始化城市
void initCity(Store<AppState> store) async {
  final prefs = await SharedPreferences.getInstance(); //获取 prefs

  String city = prefs.getString('curCity'); //获取 key 为 curCity 的值

  if (city == null || city.isEmpty) {
    //如果 city 为空，则使用默认值
    city = '上海';
  }

  store.dispatch(ChangeCityAction(city));

}

//  获取电影数据
void getData(Store<AppState> store, ChangeCityAction action)async{
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city='+action.city+'&start=0&count=10&client=&udid=');
    //成功获取数据
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      store.dispatch(FetchHotMovieListSuccessAction(200, serverDataList));
    } else {
      //获取数据失败
      store.dispatch(FetchHotMovieListErrorAction(response.statusCode));
    }
  }