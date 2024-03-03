import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import '../../../model/task.dart';
import '../../utils/const.dart';
import '../../utils/new_task.dart';
import 'uncompleted_task.dart';

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  List<TaskList>? listTasks;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    if (provider.task.isNotEmpty)
      listTasks = provider.task[provider.currentTaskIs].taskList;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (provider.task.isNotEmpty &&
            provider.task[provider.currentTaskIs].taskList != null)
          Row(
            children: [
              Flexible(
                child: ListTile(
                  leading: Icon(
                    Icons.add_task_rounded,
                    color: Colors.blueAccent,
                  ),
                  title: Text("Add a task"),
                  onTap: () {
                    newTaskAdded(context);
                  },
                  titleTextStyle: TextStyle(color: Colors.blueAccent),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        if (listTasks?.isNotEmpty ?? false)
          Expanded(
            child: UncompletedTask(),
          ),
        if (listTasks?.isEmpty ?? true)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade50,
                  radius: 150,
                  child: Image.asset(
                    "${MyTodoImages.todo_home}",
                  ),
                ),
                Text(
                  "No tasks yet",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "Add your to-dos and keep track",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ListTile(
          leading: Icon(Icons.arrow_right_outlined),
          title: Text("Completed"),
          onTap: () {},
        ),
        Visibility(
          visible: false,
          child: ListView.builder(
            itemCount: 0,
            itemBuilder: (context, index) => ListTile(),
          ),
        )
        // Text("data"),
      ],
    );
  }
}
