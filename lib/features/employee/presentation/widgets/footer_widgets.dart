import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'custom_btn.dart';

class FootWidget extends StatelessWidget {
  const FootWidget({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomBtn(
              context: context,
              width: MediaQuery.of(context).size.width / 4,
              isSelected: false,
              label: "Cancel",
              onPressed: onCancel,
            ),
            SizedBox(width: 16),
            CustomBtn(
              context: context,
              width: MediaQuery.of(context).size.width / 4,
              isSelected: true,
              label: "Save",
              onPressed: onSave,
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
