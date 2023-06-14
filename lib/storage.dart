class Storage {
  List<Task?> tasks = [
    Task(id: 1, title: 'Купить молока', completed: true),
    Task(id: 2, title: 'Купить квартиру в Москве'),
    Task(id: 3, title: 'Сходить в спортзал', completed: true),
    Task(id: 4, title: 'Прочитать Атлант Расправил Плечи'),
    Task(id: 5, title: 'Найти девушку с зп 300к руб.'),
  ];

  Storage() {
    // todo: load tasks from persistent storage or by network
  }

  List<Task?> listTasks({bool all = false}) {
    if (all) return tasks;

    // select uncompleted tasks only
    final arr = <Task?>[];
    for (var task in tasks) {
      if (!task!.completed) arr.add(task);
    }
    return arr;
  }

  int countCompletedTasks() {
    int n = 0;
    for (var task in tasks) {
      if (task!.completed) n++;
    }
    return n;
  }

  Task getTaskByID(int id) {
    final i = _taskIdx(id);
    if (i >= 0) return tasks[i]!;
    return Task(id: id);
  }

  int addTask() {
    final id = (tasks.last?.id ?? 0) + 1;
    tasks.add(Task(
      id: id,
      title: '',
    ));
    return id;
  }

  updateTask(Task task) {
    if (task.id == 0) task.id = addTask();
    tasks[_taskIdx(task.id)] = task;
  }

  removeTask(int id) {
    if (id != 0) tasks.removeAt(_taskIdx(id));
  }

  int _taskIdx(int id) {
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i]!.id == id) return i;
    }
    return -1;
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
    this.priority = '',
    this.to,
  });

  Task copy() {
    return Task(
      id: id,
      title: title,
      completed: completed,
      to: to,
      priority: priority,
    );
  }
}
