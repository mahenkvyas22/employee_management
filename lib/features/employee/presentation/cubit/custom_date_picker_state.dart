import 'package:equatable/equatable.dart';

class DatePickerState extends Equatable {
  final DateTime? selectedDate;

  const DatePickerState(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];

  DatePickerState copyWith({DateTime? selectedDate}) {
    return DatePickerState(selectedDate ?? this.selectedDate);
  }
}
