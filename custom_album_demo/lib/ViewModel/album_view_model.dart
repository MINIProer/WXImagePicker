import 'package:custom_album_demo/models/album_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_album_manager/photo_album_manager.dart';

class JRAlbumViewModel extends ChangeNotifier {
  List<JRAlbumModel> _mediaItems = [];

  List<JRAlbumModel> get mediaItems {
    return _mediaItems;
  }

  List<JRAlbumModel> _selectMediaItems = [];

  List<JRAlbumModel> get selectMediaItems {
    return _selectMediaItems;
  }

  JRAlbumViewModel() {
    initPlatformState();
  }

  void changeSelectStatus(int index) {
    JRAlbumModel albumModel = mediaItems[index];
    albumModel.isSelected = !albumModel.isSelected;
    notifyListeners();
  }

  void addMediaItemToSeletList(JRAlbumModel albumModel) {
    _selectMediaItems.add(albumModel);
    notifyListeners();
  }

  void removeMediaItemToSeletList(JRAlbumModel albumModel) {
    _selectMediaItems.remove(albumModel);
    notifyListeners();
  }

  void removeAllSelectedItems() {
    _selectMediaItems = [];
    notifyListeners();
  }

  void removeAllItemSelectStatus() {
    for (var mediaItem in _selectMediaItems) {
      JRAlbumModel albumModel = mediaItem;
      albumModel.isSelected = false;
    }
    notifyListeners();
  }

  // 数据源:获取所有照片
  Future<void> initPlatformState() async {
    List<AlbumModelEntity> photos =
        await PhotoAlbumManager.getDescAlbum(maxCount: 20);
    for (var model in photos) {
      JRAlbumModel albumModel = JRAlbumModel(false, model);
      _mediaItems.add(albumModel);
    }
    notifyListeners();
  }
}
