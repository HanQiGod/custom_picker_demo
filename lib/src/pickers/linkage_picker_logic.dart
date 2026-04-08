import '../models/link_data.dart';

class LinkagePickerStateData {
  LinkagePickerStateData({
    required this.levelNodes,
    required this.selectedIndexes,
  });

  final List<List<LinkData>> levelNodes;
  final List<int> selectedIndexes;
}

class LinkagePickerLogic {
  static LinkagePickerStateData initialize({
    required List<LinkData> data,
    List<String>? initialValues,
  }) {
    final List<List<LinkData>> levelNodes = List<List<LinkData>>.generate(
      3,
      (_) => <LinkData>[],
    );
    final List<int> selectedIndexes = List<int>.filled(3, 0);

    levelNodes[0] = data;
    selectedIndexes[0] = _matchIndex(levelNodes[0], _valueAt(initialValues, 0));

    levelNodes[1] = _childrenForParent(levelNodes[0], selectedIndexes[0]);
    selectedIndexes[1] = _matchIndex(levelNodes[1], _valueAt(initialValues, 1));

    levelNodes[2] = _childrenForParent(levelNodes[1], selectedIndexes[1]);
    selectedIndexes[2] = _matchIndex(levelNodes[2], _valueAt(initialValues, 2));

    return LinkagePickerStateData(
      levelNodes: levelNodes,
      selectedIndexes: selectedIndexes,
    );
  }

  static void updateSelection({
    required List<List<LinkData>> levelNodes,
    required List<int> selectedIndexes,
    required int columnIndex,
    required int position,
  }) {
    if (levelNodes[columnIndex].isEmpty ||
        position >= levelNodes[columnIndex].length) {
      return;
    }

    selectedIndexes[columnIndex] = position;

    if (columnIndex == 0) {
      levelNodes[1] = _childrenForParent(levelNodes[0], selectedIndexes[0]);
      selectedIndexes[1] = 0;
      levelNodes[2] = _childrenForParent(levelNodes[1], selectedIndexes[1]);
      selectedIndexes[2] = 0;
      return;
    }

    if (columnIndex == 1) {
      levelNodes[2] = _childrenForParent(levelNodes[1], selectedIndexes[1]);
      selectedIndexes[2] = 0;
    }
  }

  static List<String> currentValues({
    required List<List<LinkData>> levelNodes,
    required List<int> selectedIndexes,
  }) {
    final List<String> values = <String>[];

    for (int level = 0; level < levelNodes.length; level++) {
      if (levelNodes[level].isEmpty) {
        continue;
      }

      final int safeIndex = selectedIndexes[level].clamp(
        0,
        levelNodes[level].length - 1,
      );
      values.add(levelNodes[level][safeIndex].name);
    }

    return values;
  }

  static String? _valueAt(List<String>? values, int index) {
    if (values == null || index >= values.length) {
      return null;
    }
    return values[index];
  }

  static int _matchIndex(List<LinkData> nodes, String? targetName) {
    if (nodes.isEmpty || targetName == null) {
      return 0;
    }

    final int index = nodes.indexWhere(
      (LinkData item) => item.name == targetName,
    );
    return index == -1 ? 0 : index;
  }

  static List<LinkData> _childrenForParent(
    List<LinkData> parents,
    int selectedIndex,
  ) {
    if (parents.isEmpty) {
      return const <LinkData>[];
    }

    final int safeIndex = selectedIndex.clamp(0, parents.length - 1);
    return parents[safeIndex].children ?? const <LinkData>[];
  }
}
