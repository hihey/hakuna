import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

import 'package:hakuna/public.dart';

class MyScene extends StatefulWidget {
  _MySceneState createState() => _MySceneState();
}

class _MySceneState extends State<MyScene> with RouteAware{
  String avatarUrl = 'https://gss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D600%2C800/sign=c7ebbb733b12b31bc739c52fb6281a42/cc11728b4710b9127c9ad1cac1fdfc03924522ae.jpg';

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: Container(
          color: AppColor.white,
          height: Screen.height,
          width: Screen.width,
          child: ListView(
            padding: EdgeInsets.only(top: 0),
            children: <Widget>[
              _buildHeader(),
              _buildItem('assets/images/icon_github.png', '项目地址', _openGithub),
              _buildItem('assets/images/icon_wechat.png', '我的微信号', _copyWechatNumber),
              _buildItem('assets/images/icon_API.png', '使用说明', _openApi),
            ],
          )),
    );
  }

  _openGithub() {
    AppNavigator.push(context, WebViewScene(url: 'https://github.com/hihey/hakuna',title: 'hihey',));
  }

  _openApi() {
    AppNavigator.push(context, WebViewScene(url: 'https://github.com/hihey/hakuna/blob/master/README.md',title: 'README',));
  }

  _copyWechatNumber() {
    Clipboard.setData(ClipboardData(text:'1397009898'));
    Toast.show('已复制微信号');
  }

  Widget _buildItem(String icon, String text, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: Screen.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColor.lightGrey, width: 0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  icon,
                  fit: BoxFit.cover,
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    double width = Screen.width;
    double height = 250;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          Image(
            image: CachedNetworkImageProvider(avatarUrl),
            fit: BoxFit.cover,
            width: Screen.width,
            height: height,
          ),
          Opacity(
            opacity: 0.7,
            child: Container(color: Colors.black, width: Screen.width, height: height),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
                width: Screen.width,
                height: height,
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(avatarUrl),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('hihey',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.white,))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
