import 'package:flutter_doubanmovie/ui/hot/HotMovieData.dart';

class InitAction {
  InitAction();
}

class ChangeCityAction {
  String city;
  ChangeCityAction(this.city);
}

class FetchHotMovieListSuccessAction {
  int _code;
  List<HotMovieData> _hotMovieList;
  get code => _code;
  get hotMovieList => _hotMovieList;
  FetchHotMovieListSuccessAction(this._code, this._hotMovieList);
}

class FetchHotMovieListErrorAction {
  int _code;
  get code => _code;
  FetchHotMovieListErrorAction(this._code);
}


