import 'package:flutter/material.dart';

class Exercise extends ChangeNotifier {
  final String _id;
  final DateTime _date;
  final String _type;
  final int _count;
  int _done;

  String get id => _id;

  DateTime get date => _date;

  String get type => _type;

  int get count => _count;

  int get done => _done;

  set done(int value) {
    _done = value;
    notifyListeners();
  }

  Exercise(this._id, this._date, this._type, this._count, this._done);

  Exercise.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        _date = DateTime.parse(json['date']),
        _type = json['type'],
        _count = json['count'],
        _done = json['done'];
}
