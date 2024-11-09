part of 'employee_bloc.dart';

abstract class EmployeeState {}

class EmployeeInitialState extends EmployeeState {}

class EmployeeLoadedState extends EmployeeState {
  final List<Employee> employeeList;

  EmployeeLoadedState({required this.employeeList});
}
