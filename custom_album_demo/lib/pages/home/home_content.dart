import 'dart:io';

import 'package:custom_album_demo/ViewModel/album_view_model.dart';
import 'package:custom_album_demo/models/album_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:custom_album_demo/extensions/int_extension.dart';

class JRHomeContent extends StatefulWidget {
  @override
  _JRHomeContentState createState() => _JRHomeContentState();
}

class _JRHomeContentState extends State<JRHomeContent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (photos.length == 0 || photos == null) {
    return Consumer<JRAlbumViewModel>(builder: (context, albumVM, child) {
      if (albumVM.selectMediaItems.length == 0) {
        return Container(alignment: Alignment.center, child: Text('暂无数据'));
      } else {
        return GridView.builder(
            itemCount: albumVM.selectMediaItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.px,
                mainAxisSpacing: 2.px),
            itemBuilder: (context, index) {
              JRAlbumModel albumModel = albumVM.selectMediaItems[index];
              return Container(
                child: Image.file(
                  File(albumModel.model.thumbPath ?? albumModel.model.originalPath),
                  fit: BoxFit.cover,
                ),
              );
            });
      }
    });
    // }
    // return Container(
    //   child: ListView.builder(
    //       itemCount: photos.length,
    //       itemBuilder: (context, index) {
    //         AlbumModelEntity model = photos[index];
    //         return Image.file(
    //           File(model.thumbPath ?? model.originalPath),
    //           fit: BoxFit.cover,
    //         );
    //       }),
    // );
  }
}
