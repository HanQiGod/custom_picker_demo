import 'package:flutter/material.dart';

class PickerBottomSheetShell extends StatelessWidget {
  const PickerBottomSheetShell({
    super.key,
    required this.title,
    required this.columnTitles,
    required this.columns,
    required this.onCancel,
    required this.onConfirm,
  }) : assert(columnTitles.length == columns.length);

  final String title;
  final List<String> columnTitles;
  final List<Widget> columns;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

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
                  TextButton(onPressed: onCancel, child: const Text('取消')),
                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  TextButton(onPressed: onConfirm, child: const Text('确定')),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: List<Widget>.generate(columnTitles.length * 2 - 1, (
                    int index,
                  ) {
                    if (index.isOdd) {
                      return Container(
                        width: 1,
                        margin: const EdgeInsets.symmetric(vertical: 28),
                        color: const Color(0xFFE3E8F0),
                      );
                    }

                    final int columnIndex = index ~/ 2;
                    return Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            columnTitles[columnIndex],
                            style: const TextStyle(
                              color: Color(0xFF617082),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Expanded(child: columns[columnIndex]),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
