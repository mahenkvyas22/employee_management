import 'package:hive_flutter/hive_flutter.dart';
import '../models/employee.dart';

class HiveDatabase {
  static const String boxName = "employees";

  Future<void> initDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeeAdapter()); // Register the Employee adapter
    await Hive.openBox<Employee>(boxName);
  }

  Box<Employee> getEmployeeBox() {
    return Hive.box<Employee>(boxName);
  }

  Future<void> addEmployee(Employee employee) async {
    final box = getEmployeeBox();
    await box.add(employee);
  }

  Future<void> updateEmployee(String id, Employee updatedEmployee) async {
    final box = getEmployeeBox();

    // Find the key associated with the employee by matching the UUID
    var employeeKey = box.keys.firstWhere(
      (key) => box.get(key)?.id == id,
      orElse: () => null,
    );

    if (employeeKey != null) {
      await box.put(employeeKey, updatedEmployee);
      print('Employee with ID $id updated successfully');
    }
  }

  Future<bool> deleteEmployee(String id) async {
    final box = getEmployeeBox();
    var employeeKey = box.keys.firstWhere(
      (key) => box.get(key)?.id == id,
      orElse: () => null,
    );

    if (employeeKey != null) {
      await box.delete(employeeKey);
      print('Employee with ID $id deleted successfully');
      return true;
    } else {
      return false;
    }
  }

  List<Employee> getAllEmployees() {
    final box = getEmployeeBox();

    return box.values.toList();
  }
}
