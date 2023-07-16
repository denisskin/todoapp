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
    List<Task> tasks = [];
    bool taskExists(String id) {
      for (final task in tasks) {
        if (task.id == id) return true;
      }
      return false;
    }

    test('Get all records', () async {
      tasks = await client.getTasks();

      expect(tasks, isNotEmpty);
      expect(taskExists(newId), false);
    });

    test('Put new Task', () async {
      final task = await client.putTask(newTask);

      expect(task.toJson(), newTask.toJson());
    });

    test('Refresh all records', () async {
      tasks = await client.getTasks();

      expect(tasks, isNotEmpty);
      expect(taskExists(newId), true);
    });

    test('Delete task', () async {
      final ok = await client.deleteTask(newId);

      expect(ok, true);
      tasks = await client.getTasks(); // refresh tasks
      expect(taskExists(newId), false);
    });
  });
}
