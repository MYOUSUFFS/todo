import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider.dart';
import '../../../model/task.dart';
import '../../utils/new_task.dart';
import '../../widget/task_widget.dart';

class SubTasksList extends StatelessWidget {
  const SubTasksList({super.key, required this.viewIs});
  final bool viewIs;

  final bool edit = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    List<TaskList> task = provider.task[provider.currentTaskIs].taskList ?? [];

    if (provider.sortBy == "old") {
      task.sort((a, b) =>
          (b.taskEndDate ?? b.taskId).compareTo(a.taskEndDate ?? a.taskId));
    } else if (provider.sortBy == "new") {
      task.sort((a, b) =>
          ((a.taskEndDate ?? a.taskId).compareTo(b.taskEndDate ?? b.taskId)));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (task[index].taskStatus == viewIs)
          return InkWell(
              onTap: () {
                editTask(context, task[index]);
              },
              child: TaskView(task: task[index]));
        else
          return SizedBox();
      },
      itemCount: task.length,
    );
  }
}

class TaskWidget extends StatelessWidget {
  const TaskWidget(
      {super.key, required this.index, required this.date, required this.edit});

  final int index;
  final DateTime date;
  final bool edit;

  Color identifyPriority(DateTime taskDate) {
    DateTime now = DateTime.now();
    if (taskDate.isBefore(now)) {
      return Colors.red; // If the task is overdue, show it in red color
    } else if ((taskDate.day - now.day) <= 1 &&
        (taskDate.month == now.month || taskDate.year == now.year)) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.circle_outlined),
      title: edit
          ? TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
              minLines: 1,
              maxLines: 4,
            )
          : Text(
              'Uncompleted Task $index',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          edit
              ? TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    hintText: "Details",
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                  minLines: 1,
                  maxLines: 4,
                )
              : Text(
                  "Task $index",
                  style: const TextStyle(
                      color: Colors.grey, overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
          edit
              ? InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        Text(" Date/Time"),
                      ],
                    ),
                  ),
                )
              : Text(
                  DateFormat("EEE, dd MMM").format(date),
                  style: TextStyle(
                    color: identifyPriority(date),
                  ),
                ),
          if (edit) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 40),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}
