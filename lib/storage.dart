class Storage {
  List<Task?> tasks = [
    Task(id: 1, title: 'Покупки'),
    Task(id: 2, title: 'Сходить в спортзал', completed: true),
    Task(id: 3, title: 'Прочитать книгу'),
  ];

  Storage() {
    // todo: load tasks from persistent storage
  }

  List<Task?> listTasks({bool all = false}) {
    if (all) return tasks;

    return tasks;
  }

  int countDone() {
    int n = 0;
    tasks.forEach((task) {
      if (task!.completed) n++;
    });
    return n;
  }

  Task getTaskByID(int id) {
    if (id <= 0) {
      return Task();
    }
    return tasks[id - 1] ?? Task(id: id);
  }

  int addTask() {
    final id = tasks.length + 1;
    tasks.add(Task(
      id: id,
      title: '', //'''Задание #$id',
      completed: false,
    ));
    return id;
  }

  setTask(Task task) {
    if (task.id == 0) {
      return addTask();
    }
    tasks[task.id - 1] = task;
  }
}

class Task {
  int id;
  String title;
  bool completed;
  DateTime? to;
  String priority;

  Task({
    this.id = 0,
    this.title = '',
    this.completed = false,
    this.priority = '', // TaskPriority.no,
  });
}
