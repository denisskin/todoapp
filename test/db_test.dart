import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/providers/db.dart';
import 'package:todoapp/providers/models/task.dart';
import 'package:todoapp/utils/utils.dart';

void main() {
  group('DB tests', () {
    final db = DB.tasks;

    // new task for testing
    final newId = uniqueId();
    final newTask = Task(id: newId, text: 'New Test Task');

    test('Get a non-existent task', () async {
      final task = db.get(newId);

      expect(task.isNew(), true);
      expect(task.id, isEmpty);
      expect(task.text, isEmpty);
    });

    test('Put new Task', () async {
      await db.update(newTask);

      final task = db.get(newId);
      expect(task.isNew(), false);
    });

    /*
    test('Get task by id', () async {
      final task = db.get(newId);

      expect(task.id, isNotEmpty);
      expect(task.text, isNotEmpty);
      expect(task.toJson(), newTask.toJson());
    });

    test('Get all records', () async {
      final tasks = db.listAll();

      expect(tasks, isNotEmpty);
    });

    test('Delete task', () async {
      db.remove(newId);

      final task = db.get(newId);
      expect(task.isNew(), true);
    });
    // */
  });
}
