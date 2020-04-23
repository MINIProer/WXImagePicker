
import 'package:custom_album_demo/pages/album/album.dart';
import 'package:custom_album_demo/pages/home/home.dart';
import 'package:flutter/material.dart';

class JRRouter {
  static const String initialRoute = JRHomePage.routeName;

  static final Map<String, WidgetBuilder> routes = {
    JRHomePage.routeName: (ctx) => JRHomePage()
  };

  // 钩子函数
  static final RouteFactory generateRoute = (setttings) {
    if (setttings.name == JRAlbumPage.routeName) { // modal方式弹出页面
        return MaterialPageRoute(builder: (ctx) {
          return JRAlbumPage();
        },
        fullscreenDialog: true
      );
    }

    return null;
  };
}
