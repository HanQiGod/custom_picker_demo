import 'package:flutter/material.dart';

class PickerSelectionOverlay extends StatelessWidget {
  const PickerSelectionOverlay({super.key});

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
