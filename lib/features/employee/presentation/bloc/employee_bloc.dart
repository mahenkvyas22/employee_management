import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_management/core/theme/colors.dart';
import 'package:employee_management/features/employee/data/datasources/hive_database.dart';
import 'package:employee_management/features/employee/data/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final HiveDatabase database;
  Employee? _recentlyDeletedEmployee;
  EmployeeBloc({required this.database}) : super(EmployeeInitialState()) {
    on<LoadEmployees>(onLoadEmployees);

    on<AddEmployee>(onAddedEmployee);

    on<UpdateEmployee>(onUpdateEmployee);

    on<DeleteEmployee>(onDeleteEmployee);
    on<RestoreEmployee>(onRestoreEmployee);
  }

  void onLoadEmployees(LoadEmployees event, Emitter<EmployeeState> emit) async {
    final employees = database.getAllEmployees();

    emit(EmployeeLoadedState(employeeList: employees));
  }

  void onAddedEmployee(AddEmployee event, Emitter<EmployeeState> emit) async {
    await database.addEmployee(event.employee);
    Navigator.of(event.ctx).pop();
    add(LoadEmployees());
  }

  void onUpdateEmployee(
      UpdateEmployee event, Emitter<EmployeeState> emit) async {
    await database.updateEmployee(event.id, event.employee);
    Navigator.of(event.ctx).pop();
    add(LoadEmployees());
  }

  void onDeleteEmployee(
      DeleteEmployee event, Emitter<EmployeeState> emit) async {
    _recentlyDeletedEmployee = event.employee;

    var resp = await database.deleteEmployee(event.id);
    if (resp) {
      ScaffoldMessenger.of(event.ctx).showSnackBar(
        SnackBar(
          content: Text(
            'Employee data has been deleted',
          ),
          action: SnackBarAction(
            label: "Undo",
            textColor: AppColors.primaryColor,
            onPressed: () async {
              await database.addEmployee(event.employee);

              add(LoadEmployees());
            },
          ),
        ),
      );
    }
    add(LoadEmployees());
  }

  FutureOr<void> onRestoreEmployee(
      RestoreEmployee event, Emitter<EmployeeState> emit) async {
    await database.addEmployee(_recentlyDeletedEmployee!);

    add(LoadEmployees());
  }
}
