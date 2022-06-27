extension CompareDate on DateTime {
  bool isSameDate(DateTime o) {
    return day == o.day && month == o.month && year == o.year;
  }
}