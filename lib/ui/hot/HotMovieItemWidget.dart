import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doubanmovie/ui/hot/HotMovieData.dart';

class HotMovieItemWidget extends StatefulWidget{
  HotMovieData hotMovieData;
  HotMovieItemWidget(this.hotMovieData);
  
  @override
  State<StatefulWidget> createState() {
    return HotMovieItemWidgetState();
  }
}

class HotMovieItemWidgetState extends State<HotMovieItemWidget>{

  static const methodChannel = const MethodChannel('flutter.doubanmovie/buy');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 160,
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // 左边的图片
          Image.network(
            widget.hotMovieData.images.small,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),

          // 电影信息
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.hotMovieData.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.hotMovieData.rating.average.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text(
                    '导演：' + widget.hotMovieData.getDirectors(),
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.fade,
                  ),
                  // 因为Text没有定义宽度，要在外层包裹Expanded变成弹性盒子，overflow才有效果
                  Expanded(
                    child: Text(
                    '主演：' + widget.hotMovieData.getCasts(),
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    overflow: TextOverflow.fade, 
                  ),
                  )
                ],
              ),
            )
          ),
          // 购票信息
          Container(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.hotMovieData.collectCount.toString()+'人看过',
                  style: TextStyle(color: Colors.red,fontSize: 14),
                ),
                OutlineButton(
                  child: Text('购票', style: TextStyle(fontSize: 16),),
                  color: Colors.red,
                  textColor: Colors.red,
                  highlightedBorderColor: Colors.red,
                  borderSide: BorderSide(color: Colors.red),
                  onPressed: (){
                    methodChannel.invokeMethod('buyTicket', '购买' + widget.hotMovieData.title + '电影票一张');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}