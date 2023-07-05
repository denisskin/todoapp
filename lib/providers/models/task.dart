import 'package:todoapp/utils/utils.dart';

class Task {
  String id;
  String text;
  String importance;
  DateTime? deadline;
  bool done;
  String color;
  int createdAt;
  int changedAt;
  String lastUpdatedBy;

  static const importanceLow = 'low';
  static const importanceBasic = 'basic';
  static const importanceImportant = 'important';

  Task({
    this.id = '',
    this.text = '',
    this.done = false,
    this.importance = '',
    this.deadline,
    this.color = '',
    this.createdAt = 0,
    this.changedAt = 0,
    this.lastUpdatedBy = '',
  });

  // static Task newTask(String deviceId) {
  //   final ts = toUnix(DateTime.now());
  //   return Task(
  //     id: uniqueId(),
  //     createdAt: ts,
  //     changedAt: ts,
  //     lastUpdatedBy: deviceId,
  //   );
  // }

  Task copy() {
    return Task(
      id: id,
      text: text,
      done: done,
      importance: importance,
      deadline: deadline,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'importance': importance != '' ? importance : importanceBasic,
      'deadline': toUnix(deadline),
      'done': done,
      'color': color,
      'created_at': createdAt,
      'changed_at': changedAt,
      'last_updated_by': lastUpdatedBy,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      text: json['text'],
      done: json['done'],
      color: json['color'] ?? '',
      deadline: unixToDatetime(json['deadline']),
      importance: json['importance'],
      createdAt: json['created_at'],
      changedAt: json['changed_at'],
      lastUpdatedBy: json['last_updated_by'],
    );
  }

  static List<Task?> listFromJson(List<dynamic> json) {
    final tt = <Task?>[];
    for (var e in json) {
      tt.add(Task.fromJson(e));
    }
    return tt;
  }

  bool isNew() {
    return id == '';
  }

  String deadlineString() {
    return deadline!.toString().substring(0, 10);
  }

  bool isHighPriority() {
    return importance == importanceImportant;
  }

  bool isDeadlineSelected() {
    return deadline != null;
  }

  refreshUpdateTime() {
    changedAt = toUnix(DateTime.now());
    if (createdAt == 0) {
      createdAt = changedAt;
    }
  }
}
