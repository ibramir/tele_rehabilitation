class Exercise {
  String id;
  DateTime date;
  String type;
  int count;
  int done;

  Exercise(this.id, this.date, this.type, this.count, this.done);

  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        date = DateTime.parse(json['date']),
        type = json['type'],
        count = json['count'],
        done = json['done'];
}
