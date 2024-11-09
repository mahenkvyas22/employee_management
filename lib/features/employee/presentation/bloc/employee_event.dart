part of 'employee_bloc.dart';

abstract class EmployeeEvent {}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;
  final BuildContext ctx;
  AddEmployee({required this.employee, required this.ctx});
}

class UpdateEmployee extends EmployeeEvent {
  final String id;
  final Employee employee;
  final BuildContext ctx;
  UpdateEmployee(this.ctx, {required this.id, required this.employee});
}

class DeleteEmployee extends EmployeeEvent {
  final String id;
  final BuildContext ctx;
  final Employee employee;
  DeleteEmployee({required this.ctx, required this.id, required this.employee});
}

class RestoreEmployee extends EmployeeEvent {}
