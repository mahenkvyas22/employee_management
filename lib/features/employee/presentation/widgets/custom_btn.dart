import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn(
      {super.key,
      required this.label,
      required this.onPressed,
      required this.isSelected,
      required this.context,
      this.width});
  final BuildContext context;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? Colors.blue : Colors.blue.shade50,
          foregroundColor: isSelected ? Colors.white : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(6), // Set this to 0 for a sharp rectangle
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
