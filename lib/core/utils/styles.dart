import 'package:flutter/cupertino.dart';

import '../values/color_manager.dart';

class TextStyles {
  static TextStyle hintStyle =
      TextStyle(fontWeight: FontWeight.w400, color: ColorManager.grayColor);

  static TextStyle grayBoldStyle =
      TextStyle(fontWeight: FontWeight.bold, color: ColorManager.grayColor);

  static TextStyle whiteBoldStyle =
      TextStyle(color: ColorManager.whiteColor, fontWeight: FontWeight.bold);
}
