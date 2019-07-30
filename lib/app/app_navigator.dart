import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hakuna/public.dart';

import 'package:hakuna/movie/movie_list_view.dart';
import 'package:hakuna/movie/movie_detail/movie_detail_view.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context, 
      CupertinoPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  // 进入电影详情
  static pushMovieDetail(BuildContext context, MovieItem movie) {
    AppNavigator.push(context, MovieDetailView(id: movie.id,));
  }

  // 进入电影列表页面
  static pushMovieList(BuildContext context, String title, String action) {
    AppNavigator.push(context, MovieListView(title: title, action: action));
  }

  // 进入 webview 
  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return WebViewScene(url: url, title: title);
    }));
  }
}