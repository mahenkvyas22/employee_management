import 'package:employee_management/core/extensions/extensions.dart';
import 'package:employee_management/core/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../data/models/employee.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({super.key, required this.element, required this.onTap});
  final Employee element;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: EdgeInsets.only(bottom: 1),
        color: AppColors.whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                element.name,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              child: Text(
                element.position,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                element.lastDate == null
                    ? "From ${element.joiningDate.toDayMonthYearWithComma()}"
                    : "${element.joiningDate.toDayMonthYearWithComma()} - ${element.lastDate!.toDayMonthYearWithComma()}",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
