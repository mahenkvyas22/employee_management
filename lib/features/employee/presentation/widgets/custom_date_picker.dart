import 'package:employee_management/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../cubit/custom_date_picker_cubit.dart';
import '../cubit/custom_date_picker_state.dart';
import 'custom_btn.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime initialDate;
  final void Function(DateTime) onDateSelected;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool isJoiningDate;
  final DateTime firstDay;

  const CustomDatePicker({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    required this.onCancel,
    required this.onSave,
    required this.isJoiningDate,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick Date Selection Buttons
            BlocBuilder<DatePickerCubit, DatePickerState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (!isJoiningDate)
                          CustomBtn(
                            context: context,
                            width: MediaQuery.of(context).size.width / 3,
                            label: 'No Dates',
                            onPressed: () =>
                                context.read<DatePickerCubit>().noDate(),
                            isSelected: false,
                          ),
                        CustomBtn(
                          context: context,
                          width: MediaQuery.of(context).size.width / 3,
                          label: 'Today',
                          onPressed: () =>
                              context.read<DatePickerCubit>().selectToday(),
                          isSelected:
                              isSameDay(state.selectedDate, DateTime.now()),
                        ),
                        if (isJoiningDate)
                          CustomBtn(
                            context: context,
                            width: MediaQuery.of(context).size.width / 3,
                            label: 'Next Monday',
                            onPressed: () {
                              context
                                  .read<DatePickerCubit>()
                                  .selectNextMonday();
                            },
                            isSelected: isSameDay(
                                state.selectedDate,
                                context.read<DatePickerCubit>().getNextWeekday(
                                    DateTime.now(), DateTime.monday)),
                          ),
                      ],
                    ),
                    if (isJoiningDate)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomBtn(
                            context: context,
                            width: MediaQuery.of(context).size.width / 3,
                            label: 'Next Tuesday',
                            onPressed: () {
                              context
                                  .read<DatePickerCubit>()
                                  .selectNextTuesday();
                            },
                            isSelected: isSameDay(
                                state.selectedDate,
                                context.read<DatePickerCubit>().getNextWeekday(
                                    DateTime.now(), DateTime.tuesday)),
                          ),
                          CustomBtn(
                            context: context,
                            width: MediaQuery.of(context).size.width / 3,
                            label: 'After 1 week',
                            onPressed: () => context
                                .read<DatePickerCubit>()
                                .selectAfterOneWeek(),
                            isSelected: isSameDay(
                              state.selectedDate,
                              DateTime.now().add(
                                Duration(days: 7),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
            SizedBox(height: 16),
            // Calendar View
            BlocBuilder<DatePickerCubit, DatePickerState>(
              builder: (context, state) {
                return TableCalendar(
                  firstDay: firstDay,
                  lastDay: DateTime(2100),
                  focusedDay: state.selectedDate != null
                      ? state.selectedDate!
                      : DateTime.now(),
                  selectedDayPredicate: (day) =>
                      isSameDay(day, state.selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    context.read<DatePickerCubit>().selectDate(selectedDay);
                    onDateSelected(selectedDay);
                  },
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.arrow_left_rounded, // Customize with desired icon
                      color: Colors.blue,
                      size: 36,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_right_rounded, // Customize with desired icon
                      color: Colors.blue,
                      size: 36,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    isTodayHighlighted: true,
                    outsideDaysVisible: false,
                    todayDecoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        shape: BoxShape.circle),
                    todayTextStyle: TextStyle(color: Colors.blue),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.black),
                    // defaultTextStyle: TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            // Selected Date and Action Buttons
            BlocBuilder<DatePickerCubit, DatePickerState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Assets.event.svg(),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          state.selectedDate != null
                              ? DateFormat('d MMM yyyy')
                                  .format(state.selectedDate!)
                              : "No Date",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomBtn(
                            width: MediaQuery.of(context).size.width * 0.25,
                            label: "Cancel",
                            onPressed: onCancel,
                            isSelected: false,
                            context: context),
                        SizedBox(width: 8),
                        CustomBtn(
                            width: MediaQuery.of(context).size.width * 0.20,
                            label: "Save",
                            onPressed: onSave,
                            isSelected: true,
                            context: context)
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
