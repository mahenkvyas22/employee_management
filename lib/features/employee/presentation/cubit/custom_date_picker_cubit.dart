import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_date_picker_state.dart';

class DatePickerCubit extends Cubit<DatePickerState> {
  DatePickerCubit(DateTime initialDate) : super(DatePickerState(initialDate));

  // Select a specific date
  void selectDate(DateTime date) {
    emit(DatePickerState(date));
  }

  // Quick selection functions
  void selectToday() {
    emit(DatePickerState(DateTime.now()));
  }

  void noDate() {
    emit(DatePickerState(null));
  }

  void selectNextMonday() {
    DateTime nextMonday = getNextWeekday(DateTime.now(), DateTime.monday);
    emit(DatePickerState(nextMonday));
  }

  void selectNextTuesday() {
    DateTime nextTuesday = getNextWeekday(DateTime.now(), DateTime.tuesday);
    emit(DatePickerState(nextTuesday));
  }

  void selectAfterOneWeek() {
    DateTime afterOneWeek = DateTime.now().add(Duration(days: 7));
    emit(DatePickerState(afterOneWeek));
  }

  // Utility to get the next occurrence of a specific weekday
  DateTime getNextWeekday(DateTime current, int weekday) {
    int daysToAdd = (weekday - current.weekday + 7) % 7;
    return current.add(Duration(days: daysToAdd == 0 ? 7 : daysToAdd));
  }
}
