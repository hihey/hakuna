# hakuna

hakuna matata

常见问题：
①播放视频请关注权限问题，详见 https://github.com/flutter/plugins/tree/master/packages/video_player

Installation
First, add video_player as a dependency in your pubspec.yaml file.

iOS
Warning: The video player is not functional on iOS simulators. An iOS device must be used during development/testing.
Add the following entry to your Info.plist file, located in <project root>/ios/Runner/Info.plist:
  <key>NSAppTransportSecurity</key>
  <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
  </dict>
This entry allows your app to access video files by URL.

Android
Ensure the following permission is present in your Android Manifest file, located in 
<project root>/android/app/src/main/AndroidManifest.xml:

<uses-permission android:name="android.permission.INTERNET"/>
The Flutter project template adds it, so it may already be there.









（该项目是参考MayanDev的项目练习所用）
原作者地址 https://blog.csdn.net/qq_37954086/article/details/88955584
