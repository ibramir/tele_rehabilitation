import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/exercise.dart';

class Histogram extends StatelessWidget {
  late final List<Series<DayProgress, String>> seriesList;

  Histogram({Key? key, required List<Exercise> exercises}) : super(key: key) {
    List<DayProgress> progressList = _sumProgress(exercises);
    seriesList = [
      Series<DayProgress, String>(
          id: 'Exercises',
          data: progressList,
          colorFn: (_, __) => const Color(r: 155, g: 210, b: 170),
          domainFn: (DayProgress e, _) => DateFormat.E().format(e.date),
          measureFn: (DayProgress e, _) {
            var v = e.done / e.count;
            v = v > 1.0 ? 1.0 : v;
            return v * 100;
          })
    ];
  }

  List<DayProgress> _sumProgress(List<Exercise> exercises) {
    List<DayProgress> ret = [];
    Map<String, int> indexes = {};
    for (var e in exercises) {
      var dateFormat = DateFormat(DateFormat.YEAR_MONTH_DAY);
      String date = dateFormat.format(e.date);
      if (ret.isNotEmpty && indexes.containsKey(date)) {
        int i = indexes[date]!;
        ret[i].count += e.count;
        ret[i].done += e.done;
      } else {
        ret.add(DayProgress(e.date, e.count, e.done));
        indexes[dateFormat.format(e.date)] = ret.length - 1;
      }
    }
    ret.sort((a, b) => a.date.compareTo(b.date));
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      seriesList,
      defaultRenderer:
          BarRendererConfig(cornerStrategy: const ConstCornerStrategy(30)),
    );
  }
}

class DayProgress {
  final DateTime date;
  int count;
  int done;

  DayProgress(this.date, this.count, this.done);
}
