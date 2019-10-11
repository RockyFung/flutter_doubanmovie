import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/action/AppActions.dart';
import 'package:flutter_doubanmovie/state/AppState.dart';
import 'package:flutter_doubanmovie/ui/hot/HotMoviesListWidget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux/redux.dart';

class HotWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HotWidgetState();
  }
}

class HotWidgetState extends State<HotWidget>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initData();
  }

  // void initData() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   String city = prefs.getString('curCity');
  //   if (city != null && city.isNotEmpty) {
  //     setState((){
  //       curCity = city;
  //     });
  //   } else {
  //     setState((){
  //       curCity = '上海';
  //     });
  //   }
  // }

  void _jump2CitysWidget(Store<AppState> state,String curCity) async{
    var selectCity = await Navigator.pushNamed(context, '/Citys', arguments: curCity);
    if (selectCity == null){
      return;
    }

    // 保存数据
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('curCity', selectCity);

    state.dispatch(ChangeCityAction(selectCity));
    
  }

  @override
  Widget build(BuildContext context) {
    // return StoreConnector<CityState, String>(
    //   converter: (store){
    //     String curCity = store.state.curCity;
    //     if (curCity == null) {
    //       //如果 curCity 为 null，说明没有初始化，则触发初始化
    //       store.dispatch(InitCityAction(null));
    //     }
    //     return curCity;
    //   },
    //   builder: (context, curCity){

    //   },
    // );

    return StoreBuilder<AppState>(
      builder: (context, store){
        String curCity = store.state.cityState.curCity;
        if (curCity == null || curCity.isEmpty) {
          store.dispatch(InitAction());
          return Center(
            child: CircularProgressIndicator(),
          );
        }else{
          return creatMainWidget(store,curCity);
        }
      },
    );
  }

  Widget creatMainWidget(Store<AppState> state,String curCity){
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
            GestureDetector(
              child: Text(curCity,style: TextStyle(fontSize: 16),),
              onTap: (){
                _jump2CitysWidget(state,curCity);
              },
            ),
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
                    HotMoviesListWidget(curCity),
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