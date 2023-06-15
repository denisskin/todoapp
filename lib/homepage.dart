import 'package:flutter/material.dart';
import 'package:todoapp/db.dart';
import 'package:todoapp/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool fViewAll = false;

  @override
  Widget build(BuildContext context) {
    final tasks = fViewAll ? DB.tasks.listAll() : DB.tasks.listCurrent();

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text('Мои дела (${DB.tasks.countCompleted()})'),
      //   centerTitle: false,
      //   actions: [
      //     IconButton(
      //       icon:
      //           Icon(fViewAll ? Icons.visibility_sharp : Icons.visibility_off),
      //       onPressed: () => setState(() {
      //         fViewAll = !fViewAll;
      //       }),
      //     ),
      //   ],
      // ),
      // body: ListView.builder(
      //   itemCount: tasks.length,
      //   itemBuilder: (ctx, i) => _itemTile(ctx, tasks[i]!),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            // collapsedHeight: 50,
            // backgroundColor: TodoElementsColor.getBackPrimaryColor(context),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Мои дела', style: MyTheme.textAppBar),
              centerTitle: false,
            ),
            actions: [
              IconButton(
                icon: fViewAll ? MyTheme.iconViewAll : MyTheme.iconView,
                onPressed: () => setState(() {
                  fViewAll = !fViewAll;
                }),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(73, 0, 0, 0),
                    child: Text('Выполнено – ${DB.tasks.countCompleted()}',
                        style: MyTheme.textDone)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 40.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyTheme.colorWhite,
                      border: Border.all(color: MyTheme.colorWhite),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (ctx, i) => _itemTile(ctx, tasks[i]!),
                        ),
                        _newTaskListButton(context),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить',
        child: const Icon(Icons.add),
        onPressed: () => openTask(context, 0),
      ),
    );
  }

  Widget _itemTile(BuildContext context, Task task) {
    return Dismissible(
      key: Key('${task.id}'),
      background: Container(
        color: MyTheme.colorGreen,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Icon(Icons.check, color: Colors.white),
            ],
          ),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          setTaskComplete(task, true);
        } else {
          removeTask(task.id);
        }
        return false;
      },
      child: InkWell(
        onTap: () => openTask(context, task.id),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Checkbox(
                  value: task.completed,
                  onChanged: (v) => setTaskComplete(task, v!),
                  activeColor: MyTheme.colorGreen,
                  side: task.isHighPriority() ? MyTheme.cbxHighBorder : null,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: task.completed
                          ? MyTheme.itemCompletedTextStyle
                          : MyTheme.itemRegularTextStyle,
                    ),
                    // if (isDateSetted && !isTaskCompleted)
                    //   Text('дата', style: dateTextStyle),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              const SizedBox(
                width: 30,
                height: 30,
                child: Icon(
                  Icons.info_outline,
                  color: MyTheme.labelTertiary,
                  size: 27,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _newTaskListButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 20, 20, 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => openTask(context, 0),
              child: Text(
                'Новое',
                style: MyTheme.buttonNewTask,
              ),
            ),
          ),
        ],
      ),
    );
  }

  openTask(BuildContext context, int id) async {
    await Navigator.of(context).pushNamed('/task', arguments: id);
    setState(() {});
  }

  setTaskComplete(Task task, bool f) {
    setState(() {
      task.completed = f;
      DB.tasks.update(task);
    });
  }

  removeTask(int id) {
    setState(() {
      DB.tasks.remove(id);
    });
  }
}
