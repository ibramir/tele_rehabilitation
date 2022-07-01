extension DateExtension on DateTime {
  bool isSameDate(DateTime o) {
    return day == o.day && month == o.month && year == o.year;
  }

  DateTime dayOnly() {
    return DateTime(year, month, day);
  }

  DateTime endOfDay() {
    return add(
        const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999));
  }
}
