import 'package:flutter/material.dart';

import '../data/category_data.dart';
import '../models/link_data.dart';
import '../models/picker_engine.dart';
import '../pickers/cupertino_link_picker_sheet.dart';
import '../pickers/list_wheel_link_picker_sheet.dart';

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
  PickerEngine _currentEngine = PickerEngine.cupertino;

  @override
  void initState() {
    super.initState();
    _categoryData = buildCategoryData();
  }

  Future<void> _showPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return switch (_currentEngine) {
          PickerEngine.cupertino => CupertinoLinkPickerSheet(
            data: _categoryData,
            initialValues: _selectedValues,
            onConfirm: _updateSelection,
          ),
          PickerEngine.listWheel => ListWheelLinkPickerSheet(
            data: _categoryData,
            initialValues: _selectedValues,
            onConfirm: _updateSelection,
          ),
        };
      },
    );
  }

  void _updateSelection(List<String> selectedValues) {
    setState(() {
      _selectedValues = List<String>.from(selectedValues);
    });
  }

  void _resetSelection() {
    setState(() {
      _selectedValues = List<String>.from(_defaultSelection);
    });
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
                  engine: _currentEngine,
                  selectionText: _selectedValues.join(' / '),
                  onOpenPicker: _showPicker,
                  onReset: _resetSelection,
                ),
                const SizedBox(height: 20),
                _EngineSwitchCard(
                  selectedEngine: _currentEngine,
                  onChanged: (PickerEngine engine) {
                    setState(() {
                      _currentEngine = engine;
                    });
                  },
                ),
                const SizedBox(height: 20),
                _SelectionCard(selectedValues: _selectedValues),
                const SizedBox(height: 20),
                _ComparisonCard(selectedEngine: _currentEngine),
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
    required this.engine,
    required this.selectionText,
    required this.onOpenPicker,
    required this.onReset,
  });

  final PickerEngine engine;
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
            child: Text(
              engine.badge,
              style: const TextStyle(
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
          Text(
            engine.summary,
            style: const TextStyle(
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
                icon: Icon(engine.icon),
                label: Text(engine.actionText),
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

class _EngineSwitchCard extends StatelessWidget {
  const _EngineSwitchCard({
    required this.selectedEngine,
    required this.onChanged,
  });

  final PickerEngine selectedEngine;
  final ValueChanged<PickerEngine> onChanged;

  @override
  Widget build(BuildContext context) {
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
            '切换底层实现',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          const Text(
            '同一份层级数据和联动逻辑，对比内置 CupertinoPicker 与底层 ListWheelScrollView 的实现方式。',
            style: TextStyle(color: Color(0xFF617082), height: 1.6),
          ),
          const SizedBox(height: 16),
          SegmentedButton<PickerEngine>(
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            ),
            segments: PickerEngine.values.map((PickerEngine engine) {
              return ButtonSegment<PickerEngine>(
                value: engine,
                label: Text(engine.label),
                icon: Icon(engine.icon),
              );
            }).toList(),
            selected: <PickerEngine>{selectedEngine},
            onSelectionChanged: (Set<PickerEngine> selection) {
              onChanged(selection.first);
            },
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              selectedEngine.technicalNote,
              style: const TextStyle(color: Color(0xFF324254), height: 1.7),
            ),
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
    const List<String> labels = <String>['一级类目', '二级类目', '三级类目'];

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
            '选中的每一层都会实时驱动后续列数据刷新，适合做地区、商品类目和复杂条件筛选。',
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

class _ComparisonCard extends StatelessWidget {
  const _ComparisonCard({required this.selectedEngine});

  final PickerEngine selectedEngine;

  @override
  Widget build(BuildContext context) {
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
            '两种实现的对比',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          for (final PickerEngine engine in PickerEngine.values)
            Padding(
              padding: EdgeInsets.only(
                bottom: engine == PickerEngine.values.last ? 0 : 14,
              ),
              child: _ComparisonTile(
                engine: engine,
                isSelected: engine == selectedEngine,
              ),
            ),
        ],
      ),
    );
  }
}

class _ComparisonTile extends StatelessWidget {
  const _ComparisonTile({required this.engine, required this.isSelected});

  final PickerEngine engine;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEFF5FF) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? const Color(0xFF9CBDFF) : const Color(0xFFE1E7EF),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFE9F1FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(engine.icon, color: const Color(0xFF1F6FEB)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  engine.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  engine.summary,
                  style: const TextStyle(color: Color(0xFF617082), height: 1.6),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
