import 'dart:io';

import 'package:custom_album_demo/ViewModel/album_view_model.dart';
import 'package:custom_album_demo/models/album_model.dart';
import 'package:custom_album_demo/tools/screen_fit_tool.dart';
import 'package:flutter/material.dart';
import 'package:photo_album_manager/photo_album_manager.dart';
import 'package:custom_album_demo/extensions/int_extension.dart';
import 'package:provider/provider.dart';

class JRMediaItem extends StatelessWidget {
  final JRAlbumModel _albumModel;
  final Function _oncheck;
  final int currentIndex;

  JRMediaItem(this._albumModel, this._oncheck, {this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return buildMediaItemStackContainer();
  }

  // 媒体元素的StackContainer
  Widget buildMediaItemStackContainer() {
    return Container(
      color: Color.fromRGBO(73, 73, 73, 1),
      child: buildMediaItemStack(),
    );
  }

  // 媒体元素的Stack
  Widget buildMediaItemStack() {
    return Consumer<JRAlbumViewModel>(builder: (context, albumVM, child) {
      JRAlbumModel albumModel = albumVM.mediaItems[currentIndex];
      if (albumModel.isSelected == true) {
        return Stack(
          children: <Widget>[buildMediaItemContainer(), buildSelectedCoverContainter(), buildMediaItemSelectBox()],
        );
      }
      return Stack(
          children: <Widget>[buildMediaItemContainer(), buildMediaItemSelectBox()],
        );
    });
  }

  // 媒体元素的Container
  Widget buildMediaItemContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(73, 73, 73, 1),
      child: buildMediaItemImage(),
    );
  }

  // 媒体元素被选中的蒙层
  Widget buildSelectedCoverContainter() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(0, 0, 0, .4),
    );
  }

  // 媒体元素的Image
  Widget buildMediaItemImage() {
    AlbumModelEntity model = _albumModel.model;
    print('缩略图地址 = ${model.thumbPath}');
    return Image.file(
      File(model.thumbPath ?? model.originalPath),
      fit: BoxFit.cover,
      // cacheHeight: 300,
      // cacheWidth: 300,
    );
  }

  // 媒体元素的选择组件SelectBox
  Widget buildMediaItemSelectBox() {
    return Positioned(
        top: 5.px,
        right: 5.px,
        child: GestureDetector(
          child: Consumer<JRAlbumViewModel>(builder: (context, albumVM, child) {
            JRAlbumModel albumModel = albumVM.mediaItems[currentIndex];
            return Container(
              width: 20.px,
              height: 20.px,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  border: albumVM.selectMediaItems.length == 0
                      ? Border.all(
                          color: Colors.white,
                          width: JRScreenFitTool.setPx(1.5))
                      : (albumModel.isSelected
                          ? null
                          : Border.all(
                              color: Colors.white,
                              width: JRScreenFitTool.setPx(1.5))),
                  borderRadius: BorderRadius.circular(20.px / 2),
                  color: albumVM.selectMediaItems.length == 0
                      ? null
                      : (albumModel.isSelected
                          ? Color.fromRGBO(88, 191, 107, 1)
                          : null)),
              child: albumVM.selectMediaItems.length == 0
                  ? null
                  : albumModel.isSelected
                      ? Text(
                          '${albumVM.selectMediaItems.indexOf(albumModel) + 1}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        )
                      : null,
            );
          }),
          onTap: _oncheck,
        ));
  }
}
