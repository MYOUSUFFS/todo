import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import '../../../model/task.dart';
import '../../utils/const.dart';
import '../../utils/new_task.dart';
import 'sub_tasks.dart';

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
    if (provider.task.isNotEmpty) {
      listTasks = provider.task[provider.currentTaskIs].taskList;
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (provider.task.isNotEmpty &&
              provider.task[provider.currentTaskIs].taskList != null)
            Row(
              children: [
                Flexible(
                  child: ListTile(
                    leading: const Icon(
                      Icons.add_task_rounded,
                      color: Colors.blueAccent,
                    ),
                    title: const Text("Add a task"),
                    onTap: () {
                      newTaskAdded(context);
                    },
                    titleTextStyle: const TextStyle(color: Colors.blueAccent),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    provider.doSubTaskOptions();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          if (listTasks?.isNotEmpty ?? false)
            const Expanded(
              child: SubTasksList(viewIs: false),
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
                      MyTodoImages.todoHome,
                    ),
                  ),
                  const Text(
                    "No tasks yet",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                  const Text(
                    "Add your to-dos and keep track",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          if (provider.task.isNotEmpty &&
              provider.task[provider.currentTaskIs].taskList!.isNotEmpty)
            ListTile(
              tileColor: Colors.lightBlue.shade50.withOpacity(0.5),
              leading: Icon(provider.completedTaskShow
                  ? Icons.arrow_drop_down_outlined
                  : Icons.arrow_right_outlined),
              title: const Text("Completed"),
              onTap: () {
                provider.openCompletedTask();
              },
              trailing: Icon(
                provider.completedTaskShow ? Icons.close : null,
                color: Colors.red,
              ),
            ),
          if (provider.completedTaskShow)
            Flexible(child: SubTasksList(viewIs: true)),
        ],
      ),
    );
  }
}
