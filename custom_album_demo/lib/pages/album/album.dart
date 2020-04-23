import 'package:custom_album_demo/pages/album/album_content.dart';
import 'package:flutter/material.dart';

class JRAlbumPage extends StatelessWidget {
  static const String routeName = '/album';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: JRAlbumContent(),
    );
  }
}
