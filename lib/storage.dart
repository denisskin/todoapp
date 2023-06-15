class Storage {
  final _tasks = <Task?>[
    Task(id: 1, title: 'Купить молока', completed: true),
    Task(id: 2, title: 'Купить квартиру в Москве'),
    Task(id: 3, title: 'Сходить в спортзал', completed: true),
    Task(id: 4, title: 'Наконец-то уже дочитать Атлант расправил плечи'),
    Task(id: 5, title: 'Найти девушку с зп 300к руб.'),
  ];

  Storage() {
    // todo: load tasks from persistent storage or by network
  }

  List<Task?> allTasks() {
    return _tasks;
  }

  List<Task?> currentTasks() {
    // select uncompleted tasks only
    final arr = <Task?>[];
    for (var task in _tasks) {
      if (!task!.completed) arr.add(task);
    }
    return arr;
  }

  int countCompletedTasks() {
    int n = 0;
    for (var task in _tasks) {
      if (task!.completed) n++;
    }
    return n;
  }

  Task getTaskByID(int id) {
    final i = _taskIdx(id);
    if (i >= 0) return _tasks[i]!;
    return Task(id: id);
  }

  int addTask() {
    final id = (_tasks.last?.id ?? 0) + 1;
    _tasks.add(Task(
      id: id,
      title: '',
    ));
    return id;
  }

  updateTask(Task task) {
    if (task.id == 0) task.id = addTask();
    _tasks[_taskIdx(task.id)] = task;
  }

  removeTask(int id) {
    if (id != 0) _tasks.removeAt(_taskIdx(id));
  }

  int _taskIdx(int id) {
    for (int i = 0; i < _tasks.length; i++) {
      if (_tasks[i]!.id == id) return i;
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
