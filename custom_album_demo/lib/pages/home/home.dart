import 'package:custom_album_demo/pages/album/album.dart';
import 'package:flutter/material.dart';

import 'home_content.dart';

class JRHomePage extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自定义相册'),
      ),
      body: JRHomeContent(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () {
            print('展示照片选择器');
            Navigator.of(context).pushNamed(JRAlbumPage.routeName);
          }),
    );
  }
}
