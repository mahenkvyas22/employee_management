import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Method to format date as "21 Sep, 2022"
  String toDayMonthYearWithComma() {
    return DateFormat('dd MMM, yyyy').format(this);
  }

  // Custom method for other formats
  String format(String pattern) {
    return DateFormat(pattern).format(this);
  }
}

extension DateParsing on String {
  DateTime? convertDateTime() {
    try {
      final dateFormat = DateFormat('d MMM, yyyy');
      return dateFormat.parse(this);
    } catch (e) {
      print('Error parsing date: $e');
      return null; // Return null if parsing fails
    }
  }
}
