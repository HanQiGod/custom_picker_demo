import 'package:flutter_test/flutter_test.dart';

import 'package:custom_picker_demo/main.dart';

void main() {
  testWidgets('demo home renders core content', (WidgetTester tester) async {
    await tester.pumpWidget(const CustomPickerDemoApp());

    expect(find.text('手写三级联动 Picker Demo'), findsOneWidget);
    expect(find.text('打开 Picker'), findsOneWidget);
    expect(find.text('联动结果'), findsOneWidget);
  });
}
