import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider.dart';
import '../../utils/new_task.dart';
import '../../widget/task_widget.dart';

class UncompletedTask extends StatelessWidget {
  const UncompletedTask({super.key});

  final bool edit = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context, listen: false);
    final task = provider.task[provider.currentTaskIs].taskList;
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              editTask(context, task[index]);
            },
            child: TaskView(task: task[index]));
      },
      itemCount: task!.length,
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
