abstract class DB {
  static final tasks = TasksDB();
}

class TasksDB {
  final rows = <Task?>[
    Task(id: 1, title: 'Купить молока', completed: true),
    Task(id: 2, title: 'Купить квартиру в Москве', priority: 'low'),
    Task(id: 3, title: 'Сходить в спортзал', completed: true),
    Task(id: 4, title: 'Наконец-то уже дочитать Атлант расправил плечи'),
    Task(id: 5, title: 'Найти девушку с зп 300к руб.', priority: 'high'),
  ];

  TasksDB() {
    // todo: load tasks from persistent storage or by network
  }

  List<Task?> listAll() {
    return rows;
  }

  List<Task?> listCurrent() {
    // select uncompleted tasks only
    final arr = <Task?>[];
    for (var task in rows) {
      if (!task!.completed) arr.add(task);
    }
    return arr;
  }

  int countCompleted() {
    int n = 0;
    for (var task in rows) {
      if (task!.completed) n++;
    }
    return n;
  }

  Task get(int id) {
    final i = _idx(id);
    if (i >= 0) return rows[i]!.copy();
    return Task(id: id);
  }

  int add() {
    final id = (rows.last?.id ?? 0) + 1;
    rows.add(Task(id: id));
    return id;
  }

  update(Task task) {
    if (task.id == 0) task.id = add();
    rows[_idx(task.id)] = task;
  }

  remove(int id) {
    if (id != 0) rows.removeAt(_idx(id));
  }

  int _idx(int id) {
    for (int i = 0; i < rows.length; i++) {
      if (rows[i]!.id == id) return i;
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

  bool isHighPriority() {
    return priority == 'high';
  }
}
