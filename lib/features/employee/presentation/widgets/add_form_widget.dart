import 'package:employee_management/core/common/common.dart';
import 'package:employee_management/core/extensions/extensions.dart';
import 'package:employee_management/core/widget/custom_text_field.dart';
import 'package:employee_management/features/employee/presentation/cubit/custom_date_picker_cubit.dart';
import 'package:employee_management/features/employee/presentation/cubit/custom_date_picker_state.dart';
import 'package:employee_management/features/employee/presentation/widgets/custom_date_picker.dart';
import 'package:employee_management/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';

class AddEmployeeForm extends StatefulWidget {
  const AddEmployeeForm(
      {super.key,
      required this.empNameTextEditingController,
      required this.empRoleEditingController,
      required this.empJoiningDateEditingController,
      required this.empLastDateEditingController,
      required this.formKey,
      required this.firstDay});

  final TextEditingController empNameTextEditingController;
  final TextEditingController empRoleEditingController;
  final TextEditingController empJoiningDateEditingController;
  final TextEditingController empLastDateEditingController;
  final GlobalKey<FormState> formKey;
  final DateTime firstDay;

  @override
  State<AddEmployeeForm> createState() => _AddEmployeeFormState();
}

class _AddEmployeeFormState extends State<AddEmployeeForm> {
  Future<void> selectJoiningDate(
    BuildContext context, {
    required bool isJoiningDate,
  }) async {
    await showDialog(
        context: context,
        builder: (context) => BlocBuilder<DatePickerCubit, DatePickerState>(
              builder: (context, state) {
                return CustomDatePicker(
                  initialDate: state.selectedDate ?? DateTime.now(),
                  isJoiningDate: isJoiningDate,
                  firstDay: widget.firstDay,
                  onDateSelected: (date) {},
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  onSave: () {
                    if (isJoiningDate) {
                      widget.empJoiningDateEditingController.text =
                          state.selectedDate != null
                              ? state.selectedDate!.toDayMonthYearWithComma()
                              : '';
                    } else {
                      widget.empLastDateEditingController.text =
                          state.selectedDate != null
                              ? state.selectedDate!.toDayMonthYearWithComma()
                              : '';
                    }
                    Navigator.of(context).pop();
                  },
                );
              },
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: widget.empNameTextEditingController,
              hintText: "Employee name",
              fillColor: AppColors.whiteColor,
              borderRadius: 8,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(6),
                child: Assets.person.svg(),
              ),
              hintStyle: TextStyle(color: AppColors.textColor, fontSize: 14),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter Employee name';
                } else if (value.length < 3) {
                  return 'Employee name must be at least 3 characters';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: widget.empRoleEditingController,
              hintText: "Select role",
              borderRadius: 8,
              readOnly: true,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.primaryColor,
                  size: 38,
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(6),
                child: Assets.work.svg(),
              ),
              onTap: () async {
                String? selectedValue = await Common().showBottomSheet(context);
                if (selectedValue != null) {
                  widget.empRoleEditingController.text = selectedValue;
                }
              },
              hintStyle: TextStyle(color: AppColors.textColor, fontSize: 14),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter Employee name';
                } else if (value.length < 3) {
                  return 'Employee name must be at least 3 characters';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  child: CustomTextField(
                    hintText: "Today",
                    controller: widget.empJoiningDateEditingController,
                    borderRadius: 8,
                    readOnly: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Assets.event.svg(),
                    ),
                    onTap: () async {
                      await selectJoiningDate(
                        context,
                        isJoiningDate: true,
                        // widget.  empJoiningDateEditingController:
                        //       widget.empJoiningDateEditingController,
                        //  widget. empLastDateEditingController:
                        //       widget.empLastDateEditingController,
                        //   selectedDate: widget
                        //           .empJoiningDateEditingController.text.isNotEmpty
                        //       ? widget.empJoiningDateEditingController.text
                        //           .convertDateTime()
                        //       : null,
                      );
                    },
                    hintStyle:
                        TextStyle(color: AppColors.textColor, fontSize: 14),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter Joining date';
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.blue,
                  ),
                ),
                Flexible(
                  child: CustomTextField(
                    hintText: "No Date",
                    controller: widget.empLastDateEditingController,
                    borderRadius: 8,
                    readOnly: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Assets.event.svg(),
                    ),
                    onTap: () async {
                      await selectJoiningDate(
                        context,
                        isJoiningDate: false,
                        //  widget.   empJoiningDateEditingController:
                        //         widget.empJoiningDateEditingController,
                        //  widget.   empLastDateEditingController:
                        //         widget.empLastDateEditingController,
                        //     selectedDate:
                        //         widget.empLastDateEditingController.text.isNotEmpty
                        //             ? widget.empLastDateEditingController.text
                        //                 .convertDateTime()
                        //             : null,
                      );
                    },
                    hintStyle:
                        TextStyle(color: AppColors.textColor, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
