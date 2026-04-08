import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CustomPickerDemoApp());
}

class CustomPickerDemoApp extends StatelessWidget {
  const CustomPickerDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
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

class PickerDemoPage extends StatefulWidget {
  const PickerDemoPage({super.key});

  @override
  State<PickerDemoPage> createState() => _PickerDemoPageState();
}

class _PickerDemoPageState extends State<PickerDemoPage> {
  static const List<String> _defaultSelection = <String>[
    '电子产品',
    '手机通讯',
    '智能手机',
  ];

  late final List<LinkData> _categoryData;
  List<String> _selectedValues = List<String>.from(_defaultSelection);

  @override
  void initState() {
    super.initState();
    _categoryData = buildCategoryData();
  }

  Future<void> _showCustomPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomLinkPicker(
          data: _categoryData,
          initialValues: _selectedValues,
          onConfirm: (List<String> selected) {
            setState(() {
              _selectedValues = List<String>.from(selected);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xFFF6F1E8), Color(0xFFEAF0F7)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _HeroCard(
                  selectionText: _selectedValues.join(' / '),
                  onOpenPicker: _showCustomPicker,
                  onReset: () {
                    setState(() {
                      _selectedValues = List<String>.from(_defaultSelection);
                    });
                  },
                ),
                const SizedBox(height: 20),
                _SelectionCard(selectedValues: _selectedValues),
                const SizedBox(height: 20),
                const _FeatureCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.selectionText,
    required this.onOpenPicker,
    required this.onReset,
  });

  final String selectionText;
  final VoidCallback onOpenPicker;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF122033), Color(0xFF244A72)],
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x22122033),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              '完全掌控 UI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            '手写三级联动 Picker Demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '基于 CupertinoPicker 手写联动逻辑、滚动控制器和选中态样式，适合对 UI 和数据结构都有精细要求的场景。',
            style: TextStyle(
              color: Color(0xFFD5E5FF),
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '当前选中路径',
                  style: TextStyle(
                    color: Color(0xFFB9CEF2),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  selectionText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: <Widget>[
              FilledButton.icon(
                onPressed: onOpenPicker,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFF4C46A),
                  foregroundColor: const Color(0xFF14263A),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                icon: const Icon(Icons.tune_rounded),
                label: const Text('打开 Picker'),
              ),
              OutlinedButton.icon(
                onPressed: onReset,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.22)),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                ),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('恢复默认'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  const _SelectionCard({required this.selectedValues});

  final List<String> selectedValues;

  @override
  Widget build(BuildContext context) {
    final List<String> labels = <String>['一级类目', '二级类目', '三级类目'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE1E7EF)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x10182733),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '联动结果',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            '选中的每一层都会实时驱动后续列数据刷新，底部弹窗只依赖 Flutter 内置组件。',
            style: TextStyle(color: Color(0xFF617082), height: 1.6),
          ),
          const SizedBox(height: 18),
          for (int index = 0; index < labels.length; index++)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == labels.length - 1 ? 0 : 12,
              ),
              child: _LevelBadge(
                label: labels[index],
                value: index < selectedValues.length
                    ? selectedValues[index]
                    : '未选择',
              ),
            ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 88,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE9F1FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF1F6FEB),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard();

  @override
  Widget build(BuildContext context) {
    const List<_FeatureItemData> items = <_FeatureItemData>[
      _FeatureItemData(
        icon: Icons.view_in_ar_rounded,
        title: '选中态蒙层',
        description: '用 selectionOverlay 定义高亮边框和圆角背景，而不是依赖系统默认效果。',
      ),
      _FeatureItemData(
        icon: Icons.sync_alt_rounded,
        title: '三级联动',
        description: '第一列变化时重建第二、三列；第二列变化时重建第三列，保持数据一致。',
      ),
      _FeatureItemData(
        icon: Icons.animation_rounded,
        title: '滚动控制',
        description: '通过 FixedExtentScrollController 将后续列快速归位，维持自然的选择节奏。',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFE),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE1E7EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '这个 Demo 覆盖的要点',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          for (int index = 0; index < items.length; index++)
            Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 14,
              ),
              child: _FeatureItem(data: items[index]),
            ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  const _FeatureItem({required this.data});

  final _FeatureItemData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFE9F1FF),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(data.icon, color: const Color(0xFF1F6FEB)),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.description,
                style: const TextStyle(color: Color(0xFF617082), height: 1.6),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeatureItemData {
  const _FeatureItemData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}

class LinkData {
  const LinkData({required this.name, this.children});

  final String name;
  final List<LinkData>? children;

  bool get hasChildren => children != null && children!.isNotEmpty;
}

List<LinkData> buildCategoryData() {
  return const <LinkData>[
    LinkData(
      name: '电子产品',
      children: <LinkData>[
        LinkData(
          name: '手机通讯',
          children: <LinkData>[
            LinkData(name: '智能手机'),
            LinkData(name: '卫星电话'),
            LinkData(name: '对讲机'),
          ],
        ),
        LinkData(
          name: '电脑办公',
          children: <LinkData>[
            LinkData(name: '笔记本电脑'),
            LinkData(name: '台式电脑'),
            LinkData(name: '显示器'),
          ],
        ),
        LinkData(
          name: '影音娱乐',
          children: <LinkData>[
            LinkData(name: '投影仪'),
            LinkData(name: '蓝牙音箱'),
            LinkData(name: '游戏主机'),
          ],
        ),
      ],
    ),
    LinkData(
      name: '服装服饰',
      children: <LinkData>[
        LinkData(
          name: '男装',
          children: <LinkData>[
            LinkData(name: '上衣'),
            LinkData(name: '裤子'),
            LinkData(name: '外套'),
          ],
        ),
        LinkData(
          name: '女装',
          children: <LinkData>[
            LinkData(name: '连衣裙'),
            LinkData(name: '半身裙'),
            LinkData(name: '针织衫'),
          ],
        ),
      ],
    ),
    LinkData(
      name: '家居生活',
      children: <LinkData>[
        LinkData(
          name: '厨房用品',
          children: <LinkData>[
            LinkData(name: '锅具'),
            LinkData(name: '餐具'),
            LinkData(name: '收纳盒'),
          ],
        ),
        LinkData(
          name: '卧室家纺',
          children: <LinkData>[
            LinkData(name: '床上四件套'),
            LinkData(name: '记忆枕'),
            LinkData(name: '毛毯'),
          ],
        ),
      ],
    ),
  ];
}

class CustomLinkPicker extends StatefulWidget {
  const CustomLinkPicker({
    super.key,
    required this.data,
    this.initialValues,
    required this.onConfirm,
  });

  final List<LinkData> data;
  final List<String>? initialValues;
  final ValueChanged<List<String>> onConfirm;

  @override
  State<CustomLinkPicker> createState() => _CustomLinkPickerState();
}

class _CustomLinkPickerState extends State<CustomLinkPicker> {
  static const List<String> _columnTitles = <String>['一级类目', '二级类目', '三级类目'];

  late final List<FixedExtentScrollController> _controllers;
  late List<List<LinkData>> _levelNodes;
  late List<int> _selectedIndexes;

  @override
  void initState() {
    super.initState();
    _levelNodes = List<List<LinkData>>.generate(3, (_) => <LinkData>[]);
    _selectedIndexes = List<int>.filled(3, 0);
    _initLevels(widget.initialValues);
    _controllers = List<FixedExtentScrollController>.generate(
      3,
      (int index) =>
          FixedExtentScrollController(initialItem: _selectedIndexes[index]),
    );
  }

  void _initLevels(List<String>? initialValues) {
    _levelNodes[0] = widget.data;
    _selectedIndexes[0] = _matchIndex(
      _levelNodes[0],
      _valueAt(initialValues, 0),
    );

    _levelNodes[1] = _childrenForLevel(0);
    _selectedIndexes[1] = _matchIndex(
      _levelNodes[1],
      _valueAt(initialValues, 1),
    );

    _levelNodes[2] = _childrenForLevel(1);
    _selectedIndexes[2] = _matchIndex(
      _levelNodes[2],
      _valueAt(initialValues, 2),
    );
  }

  String? _valueAt(List<String>? values, int index) {
    if (values == null || index >= values.length) {
      return null;
    }
    return values[index];
  }

  int _matchIndex(List<LinkData> nodes, String? targetName) {
    if (nodes.isEmpty || targetName == null) {
      return 0;
    }
    final int index = nodes.indexWhere(
      (LinkData item) => item.name == targetName,
    );
    return index == -1 ? 0 : index;
  }

  List<LinkData> _childrenForLevel(int parentLevel) {
    if (_levelNodes[parentLevel].isEmpty) {
      return const <LinkData>[];
    }

    final int safeIndex = _selectedIndexes[parentLevel].clamp(
      0,
      _levelNodes[parentLevel].length - 1,
    );

    return _levelNodes[parentLevel][safeIndex].children ?? const <LinkData>[];
  }

  void _onColumnChanged(int columnIndex, int position) {
    if (_levelNodes[columnIndex].isEmpty ||
        position >= _levelNodes[columnIndex].length) {
      return;
    }

    setState(() {
      _selectedIndexes[columnIndex] = position;

      if (columnIndex == 0) {
        _levelNodes[1] = _childrenForLevel(0);
        _selectedIndexes[1] = 0;
        _levelNodes[2] = _childrenForLevel(1);
        _selectedIndexes[2] = 0;
      } else if (columnIndex == 1) {
        _levelNodes[2] = _childrenForLevel(1);
        _selectedIndexes[2] = 0;
      }
    });

    if (columnIndex == 0) {
      _resetColumn(1);
      _resetColumn(2);
    } else if (columnIndex == 1) {
      _resetColumn(2);
    }
  }

  void _resetColumn(int columnIndex) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controllers[columnIndex].hasClients) {
        return;
      }
      _controllers[columnIndex].animateToItem(
        0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    });
  }

  List<String> _selectedValues() {
    final List<String> result = <String>[];

    for (int level = 0; level < 3; level++) {
      if (_levelNodes[level].isEmpty) {
        continue;
      }

      final int safeIndex = _selectedIndexes[level].clamp(
        0,
        _levelNodes[level].length - 1,
      );
      result.add(_levelNodes[level][safeIndex].name);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      decoration: const BoxDecoration(
        color: Color(0xFFF8FBFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: const Color(0xFFD7DDE8),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('取消'),
                  ),
                  const Expanded(
                    child: Text(
                      '请选择类目',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onConfirm(_selectedValues());
                      Navigator.of(context).pop();
                    },
                    child: const Text('确定'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: List<Widget>.generate(_columnTitles.length * 2 - 1, (
                  int index,
                ) {
                  if (index.isOdd) {
                    return Container(
                      width: 1,
                      height: 220,
                      color: const Color(0xFFE3E8F0),
                    );
                  }

                  final int columnIndex = index ~/ 2;
                  return Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          _columnTitles[columnIndex],
                          style: const TextStyle(
                            color: Color(0xFF617082),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(child: _buildPickerColumn(columnIndex)),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerColumn(int columnIndex) {
    final List<LinkData> items = _levelNodes[columnIndex];
    final bool isEmpty = items.isEmpty;

    return CupertinoPicker.builder(
      scrollController: _controllers[columnIndex],
      itemExtent: 46,
      diameterRatio: 1.35,
      squeeze: 1.15,
      useMagnifier: true,
      magnification: 1.06,
      backgroundColor: Colors.transparent,
      selectionOverlay: const _PickerSelectionOverlay(),
      onSelectedItemChanged: (int position) =>
          _onColumnChanged(columnIndex, position),
      childCount: isEmpty ? 1 : items.length,
      itemBuilder: (BuildContext context, int index) {
        final String label = isEmpty ? '暂无内容' : items[index].name;
        final bool isSelected =
            !isEmpty && _selectedIndexes[columnIndex] == index;

        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isSelected ? 18 : 15,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isEmpty
                    ? const Color(0xFFB0BAC7)
                    : isSelected
                    ? const Color(0xFF1F6FEB)
                    : const Color(0xFF1D2733),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (final FixedExtentScrollController controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _PickerSelectionOverlay extends StatelessWidget {
  const _PickerSelectionOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0x141F6FEB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF9CBDFF)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF1F6FEB), width: 1.1),
            bottom: BorderSide(color: Color(0xFF1F6FEB), width: 1.1),
          ),
        ),
      ),
    );
  }
}
