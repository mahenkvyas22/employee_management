import 'package:employee_management/core/extensions/extensions.dart';
import 'package:employee_management/core/theme/colors.dart';
import 'package:employee_management/core/widget/custom_app_bar.dart';
import 'package:employee_management/core/widget/custom_text_field.dart';
import 'package:employee_management/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_management/features/employee/presentation/widgets/add_form_widget.dart';
import 'package:employee_management/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/employee.dart';
import '../widgets/custom_date_picker.dart';
import '../widgets/footer_widgets.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  const AddEditEmployeeScreen({super.key, required this.isEdit, this.employee});
  final bool isEdit;
  final Employee? employee;

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  final TextEditingController empNameTextEditingController =
      TextEditingController();
  final TextEditingController empRoleEditingController =
      TextEditingController();
  final TextEditingController empJoiningDateEditingController =
      TextEditingController();
  final TextEditingController empLastDateEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      empNameTextEditingController.text = widget.employee!.name;
      empRoleEditingController.text = widget.employee!.position;
      empJoiningDateEditingController.text =
          widget.employee!.joiningDate.toDayMonthYearWithComma();

      empLastDateEditingController.text = widget.employee!.lastDate != null
          ? widget.employee!.lastDate!.toDayMonthYearWithComma()
          : '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.isEdit == false
            ? "Add Employee Details"
            : "Edit Employee Details",
        actions: [
          if (widget.isEdit == true)
            IconButton(
                onPressed: () {
                  context.read<EmployeeBloc>().add(
                        DeleteEmployee(
                            ctx: context,
                            id: widget.employee!.id,
                            employee: widget.employee!),
                      );
                  Navigator.of(context).pop();
                },
                icon: Assets.delete.svg())
        ],
      ),
      bottomNavigationBar: kIsWeb
          ? FootWidget(
              onCancel: () {
                Navigator.of(context).pop();
              },
              onSave: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.isEdit) {
                    context.read<EmployeeBloc>().add(
                          UpdateEmployee(
                            context,
                            id: widget.employee!.id,
                            employee: Employee(
                              id: widget.employee!.id,
                              name: empNameTextEditingController.text.trim(),
                              position: empRoleEditingController.text.trim(),
                              joiningDate: empJoiningDateEditingController.text
                                  .trim()
                                  .convertDateTime()!,
                              lastDate: empLastDateEditingController.text
                                      .trim()
                                      .isNotEmpty
                                  ? empLastDateEditingController.text
                                      .trim()
                                      .convertDateTime()
                                  : null,
                              isCurrentEmployees: empLastDateEditingController
                                      .text
                                      .trim()
                                      .isNotEmpty
                                  ? false
                                  : true,
                            ),
                          ),
                        );
                  } else {
                    context.read<EmployeeBloc>().add(
                          AddEmployee(
                            ctx: context,
                            employee: Employee(
                              id: Uuid().v4(),
                              name: empNameTextEditingController.text.trim(),
                              position: empRoleEditingController.text.trim(),
                              joiningDate: empJoiningDateEditingController.text
                                  .trim()
                                  .convertDateTime()!,
                              lastDate: empLastDateEditingController.text
                                      .trim()
                                      .isNotEmpty
                                  ? empLastDateEditingController.text
                                      .trim()
                                      .convertDateTime()
                                  : null,
                              isCurrentEmployees: empLastDateEditingController
                                      .text
                                      .trim()
                                      .isNotEmpty
                                  ? false
                                  : true,
                            ),
                          ),
                        );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Please add all filed.',
                      ),
                    ),
                  );
                }
              },
            )
          : null,
      body: !kIsWeb
          ? FooterLayout(
              footer: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: FootWidget(
                  onCancel: () {
                    Navigator.of(context).pop();
                  },
                  onSave: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit) {
                        context.read<EmployeeBloc>().add(
                              UpdateEmployee(
                                context,
                                id: widget.employee!.id,
                                employee: Employee(
                                  id: widget.employee!.id,
                                  name:
                                      empNameTextEditingController.text.trim(),
                                  position:
                                      empRoleEditingController.text.trim(),
                                  joiningDate: empJoiningDateEditingController
                                      .text
                                      .trim()
                                      .convertDateTime()!,
                                  lastDate: empLastDateEditingController.text
                                          .trim()
                                          .isNotEmpty
                                      ? empLastDateEditingController.text
                                          .trim()
                                          .convertDateTime()
                                      : null,
                                  isCurrentEmployees:
                                      empLastDateEditingController.text
                                              .trim()
                                              .isNotEmpty
                                          ? false
                                          : true,
                                ),
                              ),
                            );
                      } else {
                        context.read<EmployeeBloc>().add(
                              AddEmployee(
                                ctx: context,
                                employee: Employee(
                                  id: Uuid().v4(),
                                  name:
                                      empNameTextEditingController.text.trim(),
                                  position:
                                      empRoleEditingController.text.trim(),
                                  joiningDate: empJoiningDateEditingController
                                      .text
                                      .trim()
                                      .convertDateTime()!,
                                  lastDate: empLastDateEditingController.text
                                          .trim()
                                          .isNotEmpty
                                      ? empLastDateEditingController.text
                                          .trim()
                                          .convertDateTime()
                                      : null,
                                  isCurrentEmployees:
                                      empLastDateEditingController.text
                                              .trim()
                                              .isNotEmpty
                                          ? false
                                          : true,
                                ),
                              ),
                            );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please add all filed.',
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              child: AddEmployeeForm(
                formKey: _formKey,
                empNameTextEditingController: empNameTextEditingController,
                empRoleEditingController: empRoleEditingController,
                empJoiningDateEditingController:
                    empJoiningDateEditingController,
                empLastDateEditingController: empLastDateEditingController,
                firstDay: empJoiningDateEditingController.text.isNotEmpty
                    ? empJoiningDateEditingController.text.convertDateTime()!
                    : DateTime(2000),
              ),
            )
          : AddEmployeeForm(
              formKey: _formKey,
              firstDay: empJoiningDateEditingController.text.isNotEmpty
                  ? empJoiningDateEditingController.text.convertDateTime()!
                  : DateTime(2000),
              empNameTextEditingController: empNameTextEditingController,
              empRoleEditingController: empRoleEditingController,
              empJoiningDateEditingController: empJoiningDateEditingController,
              empLastDateEditingController: empLastDateEditingController,
            ),
    );
  }
}
