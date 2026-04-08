import 'package:flutter/material.dart';

enum PickerEngine { cupertino, listWheel }

extension PickerEngineX on PickerEngine {
  String get label {
    return switch (this) {
      PickerEngine.cupertino => 'CupertinoPicker',
      PickerEngine.listWheel => 'ListWheelScrollView',
    };
  }

  String get badge {
    return switch (this) {
      PickerEngine.cupertino => 'iOS 风格滚轮',
      PickerEngine.listWheel => 'Android 风格滚轮',
    };
  }

  String get actionText {
    return switch (this) {
      PickerEngine.cupertino => '打开 CupertinoPicker',
      PickerEngine.listWheel => '打开 ListWheelScrollView',
    };
  }

  String get summary {
    return switch (this) {
      PickerEngine.cupertino => '内置 selectionOverlay，适合快速做出 iOS 风格的高亮选择器。',
      PickerEngine.listWheel => '基于底层滚轮视图自行拼装，更适合做 Android 风格和深度定制布局。',
    };
  }

  String get technicalNote {
    return switch (this) {
      PickerEngine.cupertino =>
        '当前模式直接使用 CupertinoPicker，滚动透视、放大倍率和选中蒙层都走系统能力。',
      PickerEngine.listWheel =>
        '当前模式使用 ListWheelScrollView 手写选中蒙层，适合继续扩展自定义动画和特殊布局。',
    };
  }

  IconData get icon {
    return switch (this) {
      PickerEngine.cupertino => Icons.phone_iphone_rounded,
      PickerEngine.listWheel => Icons.android_rounded,
    };
  }
}
