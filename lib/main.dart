import 'package:flutter/material.dart';
import 'package:flutter_doubanmovie/hot/CitysWidget.dart';
import 'package:flutter_doubanmovie/hot/HotWidget.dart';
import 'package:flutter_doubanmovie/mine/MineWidget.dart';
import 'package:flutter_doubanmovie/find/MoviesWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      // showPerformanceOverlay: true, // 打开性能监控工具
      // checkerboardOffscreenLayers: true, //使用了saveLayer的图像会显示为棋盘格式并随着页面刷新而闪烁
      // checkerboardRasterCacheImages: true, // 做了缓存的静态图像图片在刷新页面使不会改变棋盘格的颜色；如果棋盘格颜色变了，说明被重新缓存，这是我们要避免的
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '豆瓣电影'),
      routes: {
        '/Citys':(context)=>CitysWidget()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  final _widgetItems = [HotWidget(), MoviesWidget(), MineWidget()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: _widgetItems[_selectedIndex],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('热映')),
          BottomNavigationBarItem(icon: Icon(Icons.panorama_fish_eye), title: Text('找片')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的'))
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),

    );
  }

  _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
}
