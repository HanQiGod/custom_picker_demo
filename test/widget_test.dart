import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:custom_picker_demo/src/app.dart';
import 'package:custom_picker_demo/src/models/picker_engine.dart';

void main() {
  testWidgets('home switches picker engine labels', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CustomPickerDemoApp());

    expect(find.text('手写三级联动 Picker Demo'), findsOneWidget);
    expect(find.text('打开 CupertinoPicker'), findsOneWidget);

    final Finder segmentedButton = find.byWidgetPredicate(
      (Widget widget) => widget is SegmentedButton<PickerEngine>,
    );
    final Finder listWheelSegment = find.descendant(
      of: segmentedButton,
      matching: find.text('ListWheelScrollView'),
    );

    await tester.tap(listWheelSegment.first);
    await tester.pumpAndSettle();

    expect(find.text('打开 ListWheelScrollView'), findsOneWidget);
    expect(find.text('联动结果'), findsOneWidget);
  });
}
