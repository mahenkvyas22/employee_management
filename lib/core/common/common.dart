import 'package:employee_management/core/extensions/extensions.dart';
import 'package:employee_management/core/theme/colors.dart';
import 'package:employee_management/features/employee/presentation/cubit/custom_date_picker_cubit.dart';
import 'package:employee_management/features/employee/presentation/cubit/custom_date_picker_state.dart';
import 'package:employee_management/features/employee/presentation/widgets/custom_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Common {
  final List<String> items = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];
  Future<String?> showBottomSheet(BuildContext context) async {
    final selectedValue = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(items.length, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      items[index],
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      Navigator.pop(context, items[index]);
                    },
                  ),
                  if (index < items.length - 1)
                    const Divider(color: AppColors.greyColor),
                ],
              );
            }),
          ),
        );
      },
    );

    return selectedValue;
  }
}
