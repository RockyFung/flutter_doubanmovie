import 'package:flutter_doubanmovie/action/AppActions.dart';
import 'package:flutter_doubanmovie/state/AppState.dart';

AppState appReducer(AppState state, dynamic action){
  return AppState(changeCityReducer(state, action), hotMovieReducer(state, action));
}

CityState changeCityReducer(AppState state, dynamic action){
  if (action is ChangeCityAction){
    return CityState(action.city);
  }
  return state.cityState;
}

HotMovieState hotMovieReducer(AppState state, Object action){
  if (action is FetchHotMovieListSuccessAction) {
    return HotMovieState(action.code, action.hotMovieList);
  }else if(action is FetchHotMovieListErrorAction){
    return HotMovieState(action.code, null);
  }
  return state.hotMovieState;
}