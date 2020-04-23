import 'dart:math';

import 'package:custom_album_demo/ViewModel/album_view_model.dart';
import 'package:custom_album_demo/models/album_model.dart';
import 'package:custom_album_demo/tools/screen_fit_tool.dart';
import 'package:custom_album_demo/widgets/media_item.dart';
import 'package:flutter/material.dart';
import 'package:custom_album_demo/extensions/int_extension.dart';
import 'package:provider/provider.dart';

class JRAlbumContent extends StatefulWidget {
  @override
  _JRAlbumContentState createState() => _JRAlbumContentState();
}

class _JRAlbumContentState extends State<JRAlbumContent> {
  @override
  Widget build(BuildContext context) {
    return buildAlbumContentUI();
  }

  Widget buildAlbumContentUI() {
    return buildContentContainerView();
  }

  // 页面整体容器Container
  Widget buildContentContainerView() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: JRScreenFitTool.screenHeight,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          buildTopToolBarStackView(),
          buildAlbumContentContainerView(),
          buildBottomToolBarView()
        ],
      ),
    );
  }

  // 顶部工具栏Stack
  Widget buildTopToolBarStackView() {
    return Stack(
      children: <Widget>[
        buildTopToolBarContainerView(),
        buildCancelButtonContainerView(),
        buildTopToolBarAlbumMenuButtonContainerView()
      ],
    );
  }

  // 顶部工具栏Container
  Widget buildTopToolBarContainerView() {
    return Container(
      height: JRScreenFitTool.statusBarHeight + JRScreenFitTool.navBarHeight,
      color: Color.fromRGBO(50, 50, 50, 1),
    );
  }

  // 顶部工具栏CancelButton
  Widget buildCancelButtonContainerView() {
    return Positioned(
        left: 0,
        bottom: 0,
        child: Consumer<JRAlbumViewModel>(builder: (context, albumVM, child) {
          return GestureDetector(
            child: Container(
              width: 70.px,
              height: JRScreenFitTool.navBarHeight,
              // color: Colors.white,
              alignment: Alignment.center,
              child: Text('取消',
                  style: TextStyle(fontSize: 18.px, color: Colors.white)),
            ),
            onTap: () {
              albumVM.removeAllItemSelectStatus();
              albumVM.removeAllSelectedItems();
              // PaintingBinding.instance.imageCache.clear();
              Navigator.of(context).pop();
            },
          );
        }));
  }

  // 顶部工具栏AlbumMenuButton
  Widget buildTopToolBarAlbumMenuButtonContainerView() {
    return Positioned(
        left: JRScreenFitTool.screenWidth / 2 - 65.px,
        bottom: 5.px,
        child: Container(
          width: 130.px,
          height: JRScreenFitTool.navBarHeight - 5.px,
          padding: EdgeInsets.fromLTRB(
              (JRScreenFitTool.navBarHeight - 5.px) / 2, 0, 5.px, 0),
          decoration: BoxDecoration(
              color: Color.fromRGBO(73, 73, 73, 1),
              borderRadius: BorderRadius.circular(
                  (JRScreenFitTool.navBarHeight - 5.px) / 2)),
          child: Row(
            children: <Widget>[
              Text('相机交卷',
                  style: TextStyle(
                      fontSize: 16.px,
                      color: Colors.white)),
              SizedBox(width: 10.px),
              Container(
                width: JRScreenFitTool.navBarHeight - 20.px,
                height: JRScreenFitTool.navBarHeight - 20.px,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(160, 160, 160, 1),
                    borderRadius: BorderRadius.circular(
                        (JRScreenFitTool.navBarHeight - 20.px) / 2)),
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15.px,
                    color: Color.fromRGBO(25, 25, 25, 1),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // 中间照片展示Container
  Widget buildAlbumContentContainerView() {
    return Expanded(
        child: Container(
      width: JRScreenFitTool.screenWidth,
      padding: EdgeInsets.all(2.px),
      color: Color.fromRGBO(60, 60, 60, 1),
      child: Consumer<JRAlbumViewModel>(builder: (context, albumVM, child) {
        final mediaItems = albumVM.mediaItems;
        return GridView.builder(
            itemCount: mediaItems.length,
            padding: EdgeInsets.only(top: 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2.px,
                crossAxisSpacing: 2.px),
            itemBuilder: (ctx, index) {
              JRAlbumModel albumModel = mediaItems[index];
              return JRMediaItem(
                albumModel,
                () {
                  print('选中媒体元素的索引 = $index');
                  albumVM.changeSelectStatus(index);

                  JRAlbumModel albumModel = albumVM.mediaItems[index];

                  if (albumModel.isSelected == true) {
                    albumVM.addMediaItemToSeletList(albumModel);
                  } else {
                    albumVM.removeMediaItemToSeletList(albumModel);
                  }

                  print('albumVMSelectList = ${albumVM.selectMediaItems}');
                },
                currentIndex: index,
              );
            });
      }),
    ));
  }

  // 底部工具栏View
  Widget buildBottomToolBarView() {
    if (JRScreenFitTool.statusBarHeight == 44) {
      return buildBottomToolBarForSeriesOfIphoneX(); // X系列
    }
    return buildBottomToolBarForNormalMachineModel(); // 非X系列
  }

  // 底部工具栏View【iPhoneX系列】
  Widget buildBottomToolBarForSeriesOfIphoneX() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: 34.px + 44.px,
      color: Color.fromRGBO(50, 50, 50, 1),
      child: Column(
        children: <Widget>[
          buildBottomToolBarStackView(),
          buildButtonToolBarBottomSafeAreaContainerView()
        ],
      ),
    );
  }

  // 底部工具栏View【非iPhoneX系列】
  Widget buildBottomToolBarForNormalMachineModel() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: 44.px,
      color: Color.fromRGBO(50, 50, 50, 1),
      child: buildBottomToolBarStackView(),
    );
  }

  // 底部工具栏安全区域View【iPhoneX系列】
  Widget buildButtonToolBarBottomSafeAreaContainerView() {
    return Container(
      width: JRScreenFitTool.screenWidth,
      height: 34.px,
      color: Color.fromRGBO(50, 50, 50, 1),
    );
  }

  // 底部工具栏Stack
  Widget buildBottomToolBarStackView() {
    return Stack(
      children: <Widget>[
        buildBottomToolBarContainerView(),
        buildPreviewButtonContainerView(),
        buildSendButtonContainerView()
      ],
    );
  }

  // 底部工具栏Container
  Widget buildBottomToolBarContainerView() {
    return Container(height: 44.px, color: Color.fromRGBO(50, 50, 50, 1));
  }

  // 底部工具栏预览Button
  Widget buildPreviewButtonContainerView() {
    return Positioned(
        top: 0,
        left: 0,
        child: Container(
          width: 70.px,
          height: 44.px,
          alignment: Alignment.center,
          child: Text('预览',
              style: TextStyle(
                  fontSize: 18.px, color: Color.fromRGBO(101, 93, 93, 1))),
        ));
  }

  // 底部工具栏发送Button
  Widget buildSendButtonContainerView() {
    return Positioned(
        right: 15.px,
        bottom: 7.px,
        child: Consumer<JRAlbumViewModel>(builder: (context, albumVM, child) {
          return GestureDetector(
            child: Container(
              height: 30.px,
              padding: EdgeInsets.fromLTRB(10.px, 0, 10.px, 0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: albumVM.selectMediaItems.length == 0
                      ? Color.fromRGBO(61, 62, 64, 1)
                      : Color.fromRGBO(89, 190, 107, 1),
                  borderRadius: BorderRadius.circular(2.px)),
              child: Text(
                albumVM.selectMediaItems.length == 0
                    ? '发送'
                    : '发送(${albumVM.selectMediaItems.length})',
                style: albumVM.selectMediaItems.length == 0
                    ? TextStyle(
                        fontSize: 16.px,
                        color: Color.fromRGBO(101, 93, 93, 1),
                        fontWeight: FontWeight.bold)
                    : TextStyle(fontSize: 16.px, color: Colors.white),
              ),
            ),
            onTap: albumVM.selectMediaItems.length == 0
                ? null
                : () {
                    print('发送');
                    Navigator.of(context).pop();
                  },
          );
        }));
  }
}
