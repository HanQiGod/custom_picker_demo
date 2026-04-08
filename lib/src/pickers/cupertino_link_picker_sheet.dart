import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/link_data.dart';
import '../widgets/picker_bottom_sheet_shell.dart';
import '../widgets/picker_selection_overlay.dart';
import 'linkage_picker_logic.dart';

class CupertinoLinkPickerSheet extends StatefulWidget {
  const CupertinoLinkPickerSheet({
    super.key,
    required this.data,
    this.initialValues,
    required this.onConfirm,
  });

  final List<LinkData> data;
  final List<String>? initialValues;
  final ValueChanged<List<String>> onConfirm;

  @override
  State<CupertinoLinkPickerSheet> createState() =>
      _CupertinoLinkPickerSheetState();
}

class _CupertinoLinkPickerSheetState extends State<CupertinoLinkPickerSheet> {
  static const List<String> _columnTitles = <String>['一级类目', '二级类目', '三级类目'];

  late final List<FixedExtentScrollController> _controllers;
  late List<List<LinkData>> _levelNodes;
  late List<int> _selectedIndexes;

  @override
  void initState() {
    super.initState();
    final LinkagePickerStateData state = LinkagePickerLogic.initialize(
      data: widget.data,
      initialValues: widget.initialValues,
    );
    _levelNodes = state.levelNodes;
    _selectedIndexes = state.selectedIndexes;
    _controllers = List<FixedExtentScrollController>.generate(
      3,
      (int index) =>
          FixedExtentScrollController(initialItem: _selectedIndexes[index]),
    );
  }

  void _onColumnChanged(int columnIndex, int position) {
    setState(() {
      LinkagePickerLogic.updateSelection(
        levelNodes: _levelNodes,
        selectedIndexes: _selectedIndexes,
        columnIndex: columnIndex,
        position: position,
      );
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

  void _confirm() {
    widget.onConfirm(
      LinkagePickerLogic.currentValues(
        levelNodes: _levelNodes,
        selectedIndexes: _selectedIndexes,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PickerBottomSheetShell(
      title: 'CupertinoPicker 联动选择',
      columnTitles: _columnTitles,
      columns: List<Widget>.generate(3, _buildPickerColumn),
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: _confirm,
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
      selectionOverlay: const PickerSelectionOverlay(),
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
