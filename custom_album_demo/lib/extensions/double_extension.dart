

import 'package:custom_album_demo/tools/screen_fit_tool.dart';

extension DoubleFit on double {
  double px() {
    return JRScreenFitTool.setPx(this);
  }

  double rpx() {
    return JRScreenFitTool.setRpx(this);
  }
}
