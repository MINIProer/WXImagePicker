import 'dart:ui';

import 'package:custom_album_demo/ViewModel/album_view_model.dart';
import 'package:custom_album_demo/routers/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tools/screen_fit_tool.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => JRAlbumViewModel()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    JRScreenFitTool.initialize();
    JRScreenFitTool.setStatusBarHeight(MediaQueryData.fromWindow(window).padding.top);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: JRRouter.initialRoute,
      routes: JRRouter.routes,
      onGenerateRoute: JRRouter.generateRoute,
    );
  }
}

