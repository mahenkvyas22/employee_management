import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String position;

  @HiveField(3)
  DateTime joiningDate;

  @HiveField(4)
  DateTime? lastDate;

  @HiveField(5)
  bool isCurrentEmployees;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.joiningDate,
    required this.lastDate,
    required this.isCurrentEmployees,
  });
  factory Employee.create({
    required String name,
    required String position,
    required DateTime joiningDate,
    DateTime? lastDate,
    required bool isCurrentEmployees,
  }) {
    return Employee(
      id: Uuid().v4(), // Generate a new UUID
      name: name,
      position: position,
      joiningDate: joiningDate,
      lastDate: lastDate,
      isCurrentEmployees: isCurrentEmployees,
    );
  }
}
