import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hakuna/public.dart';
import 'package:hakuna/home/home_scene.dart';
import 'package:hakuna/my/my_scene.dart';
import 'package:hakuna/my/find_page.dart';
import 'package:hakuna/my/collect_page.dart';

class RootScene extends StatefulWidget {

  final Widget child;
  RootScene({Key key, this.child}) : super(key: key);
  _RootSceneState createState() => _RootSceneState();
}

class _RootSceneState extends State<RootScene> {
  int _tabIndex = 0;
  bool isLoaded = false;

  //定义 tab icon
  List<Image> _tabImages = [
    Image.asset('assets/images/home.png'),
    Image.asset('assets/images/movie.png'),
    Image.asset('assets/images/donut.png'),
    Image.asset('assets/images/person.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('assets/images/home_selected.png'),
    Image.asset('assets/images/movie_selected.png'),
    Image.asset('assets/images/donut_selected.png'),
    Image.asset('assets/images/person_selected.png'),
  ];

  @override
  void initState() { 
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          CollectPage(),
          HomeScene(),
          FindPage(),
          MyScene()
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        activeColor: AppColor.primary,
        border: Border(top: BorderSide.none),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0),title: Text('首页')),
          BottomNavigationBarItem(icon: getTabIcon(1),title: Text("电影")),
          BottomNavigationBarItem(icon: getTabIcon(2),title: Text("资讯")),
          BottomNavigationBarItem(icon: getTabIcon(3),title: Text("我的"))
        ],
        currentIndex: _tabIndex,
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}