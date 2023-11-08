class Task {
  static const String collectionName = 'tasks';
  String? id;
  String? title;
  String? description;
  DateTime? dateTime;
  bool? isDone;

  Task(
      {this.id = '',
      required this.title,
      required this.description,
      required this.dateTime,
      this.isDone = false});

  /// map =>object
  Task.fromFireStore(Map<String, dynamic> date)
      : this(
            id: date['id'],
            title: date['title'],
            description: date['description'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(date['dateTime']),
            isDone: date['isDone']);

  /// object => map
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime?.millisecondsSinceEpoch,
      'isDone': isDone
    };
  }
}
