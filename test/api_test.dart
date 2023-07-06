import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/api/api.dart';
import 'package:todoapp/providers/models/task.dart';
import 'package:todoapp/utils/utils.dart';

void main() {
  group('API-Client tests', () {
    final client = ApiClient();

    // new task for testing
    final newId = uniqueId();
    final newTask = Task(id: newId, text: 'New Test Task');

    // actual tasks list
    List<Task?> tasks = [];
    Task? taskByID(String id) {
      for (final task in tasks) {
        if (task?.id == id) return task;
      }
      return null;
    }

    test('Get all records', () async {
      tasks = await client.getTasks();
      expect(tasks, isNotEmpty);
      expect(taskByID(newId), isNull);
    });

    test('Put new Task', () async {
      final t = await client.putTask(newTask);
      expect(t.toJson(), newTask.toJson());
    });

    test('Refresh all records', () async {
      tasks = await client.getTasks();
      expect(tasks, isNotEmpty);
      expect(taskByID(newId), isNotNull);
    });

    test('Delete task', () async {
      await client.deleteTask(newId);
      tasks = await client.getTasks();
      expect(taskByID(newId), isNull);
    });
  });
}
