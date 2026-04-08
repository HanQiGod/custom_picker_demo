# custom_picker_demo

一个基于 Flutter 内置组件手写的三级联动选择器 demo，用来对比两种底层实现方式：

- `CupertinoPicker`
- `ListWheelScrollView`

这份项目不依赖第三方 Picker 插件，重点展示三件事：

- 如何自己维护三级联动的数据刷新逻辑
- 如何用 `FixedExtentScrollController` 控制滚动归位
- 如何完全接管选中态蒙层、分割线和弹层布局

## 效果图

![展示图](assets/images/custom_picker_demo.gif)

## Demo 包含什么

- 首页展示当前选中的三级路径
- 支持在 `CupertinoPicker` 和 `ListWheelScrollView` 两个版本之间切换
- 两个版本复用同一份层级数据和联动逻辑
- 默认内置一组商品类目示例数据
- 支持通过 `initialValues` 恢复初始选中项