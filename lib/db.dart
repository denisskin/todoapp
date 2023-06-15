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
    Task(id: 6, title: 'Найти персонажа Марио в реале', priority: 'low'),
    Task(id: 7, title: 'Сгенерировать роман больше чем Атлант расправил плечи'),
    Task(id: 8, title: 'Перезагрузить кофеварку без ошибок', completed: true),
    Task(id: 9, title: 'Исправить опечатку в бессмысленном комментарии'),
    Task(id: 10, title: 'Сходить в спортзал без перерыва на пиццу'),
    Task(id: 11, title: 'Создать приложение, которое покупает молоко'),
    Task(id: 12, title: 'Научиться программировать с закрытыми глазами'),
    Task(id: 13, title: 'Запустить скайнет и поработить мир', priority: 'low'),
    Task(id: 14, title: 'Прокачать свой Тиндер-акк', priority: 'high'),
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
