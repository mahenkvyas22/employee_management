import 'package:employee_management/core/theme/colors.dart';
import 'package:employee_management/core/widget/custom_app_bar.dart';
import 'package:employee_management/features/employee/data/models/employee.dart';
import 'package:employee_management/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:employee_management/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../widgets/listItem_widget.dart';
import 'add_edit_employee_screen.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "Employee List",
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoadedState) {
            return state.employeeList.isNotEmpty
                ? GroupedListView<Employee, bool>(
                    elements: state.employeeList,
                    padding: EdgeInsets.zero,
                    groupBy: (element) => element.isCurrentEmployees,

                    groupSeparatorBuilder: (bool isCurrent) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment
                              .centerLeft, // Align the header to the start
                          child: Text(
                            isCurrent
                                ? "Current employees"
                                : "Previous employees",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      );
                    },
                    indexedItemBuilder: (context, Employee element, index) =>
                        Align(
                      alignment:
                          Alignment.topLeft, // Align each item to the start
                      child: Dismissible(
                        key: Key(element.joiningDate.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context.read<EmployeeBloc>().add(
                                DeleteEmployee(
                                    ctx: context,
                                    id: state.employeeList[index].id,
                                    employee: element),
                              );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListItemWidget(
                          element: element,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditEmployeeScreen(
                                  isEdit: true,
                                  employee: state.employeeList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    itemComparator: (item1, item2) =>
                        item2.joiningDate.compareTo(item1.joiningDate),
                    // useStickyGroupSeparators: true,
                    floatingHeader: true,
                    order: GroupedListOrder.ASC,
                    footer: Align(
                      alignment: Alignment
                          .centerLeft, // Align footer text to the start
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Swipe left to delete",
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    emptyPlaceholder: Center(child: Assets.nodata.svg()),
                  )
                : Center(child: Assets.nodata.svg());
          } else {
            return Center(child: Assets.nodata.svg());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddEditEmployeeScreen(
                        isEdit: false,
                      )));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
