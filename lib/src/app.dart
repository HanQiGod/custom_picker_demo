import 'package:flutter/material.dart';

import 'pages/picker_demo_page.dart';

class CustomPickerDemoApp extends StatelessWidget {
  const CustomPickerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1F6FEB),
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '自定义 Picker Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF4F0E8),
        textTheme: ThemeData.light().textTheme.apply(
          bodyColor: const Color(0xFF1D2733),
          displayColor: const Color(0xFF1D2733),
        ),
      ),
      home: const PickerDemoPage(),
    );
  }
}
