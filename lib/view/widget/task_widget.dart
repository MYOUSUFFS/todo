import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../controller/provider.dart';
import '../../model/task.dart';
import '../utils/date_time.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({super.key});

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  DateTime? date;
  final TextEditingController title = TextEditingController();
  final TextEditingController details = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return ListTile(
      title: TextFormField(
        autofocus: true,
        controller: title,
        decoration: const InputDecoration(
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: details,
            decoration: const InputDecoration(
              // isCollapsed: true,
              hintText: "Details",
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            minLines: 1,
            maxLines: 4,
          ),
          InkWell(
            onTap: () async {
              final dateIs = await selectDate(context);
              if (dateIs != null) {
                date = dateIs;
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(date != null ? myDateFormate(date!) : "Date/Time"),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  final task = TaskList(
                      taskName: title.text,
                      taskDescription: details.text,
                      taskEndDate: date != null ? date.toString() : null,
                      taskStatus: false,
                      taskId: DateTime.now().toString());
                  provider.addNewTaskToList(task);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class TaskView extends StatelessWidget {
  const TaskView({super.key, required this.task});
  final TaskList task;

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
    final provider = Provider.of<MainProvider>(context);
    return ListTile(
      leading: IconButton(
        onPressed: () {
          provider.taskCompleted(task.taskId);
          toast("Task Updated");
        },
        padding: EdgeInsets.all(8),
        icon: Icon(task.taskStatus ? Icons.done : Icons.circle_outlined),
      ),
      title: Text(
        task.taskName,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 2,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (task.taskDescription != null) ...[
            Text(
              task.taskDescription!,
              style: const TextStyle(
                  color: Colors.grey, overflow: TextOverflow.ellipsis),
              maxLines: 2,
            ),
          ],
          if (task.taskEndDate != null) ...[
            Text(
              myDateFormate(DateTime.parse(task.taskEndDate!)),
              style: TextStyle(
                color: identifyPriority(DateTime.parse(task.taskEndDate!)),
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class TaskEdit extends StatefulWidget {
  const TaskEdit({super.key, required this.task});
  final TaskList task;

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  DateTime? date;
  late TextEditingController title;
  late TextEditingController details;
  @override
  void initState() {
    title = TextEditingController(text: widget.task.taskName);
    details = TextEditingController(text: widget.task.taskDescription);
    if (widget.task.taskEndDate != null) {
      date = DateTime.parse(widget.task.taskEndDate!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return ListTile(
      title: TextFormField(
        autofocus: true,
        controller: title,
        decoration: const InputDecoration(
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: details,
            decoration: const InputDecoration(
              // isCollapsed: true,
              hintText: "Details",
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            minLines: 1,
            maxLines: 4,
          ),
          InkWell(
            onTap: () async {
              final dateIs = await selectDate(context);
              if (dateIs != null) {
                date = dateIs;
                setState(() {});
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 8),
                  Text(date != null ? myDateFormate(date!) : "Date/Time"),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  provider.removeTaskFromList(widget.task.taskId);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  provider.editTaskToList(
                    widget.task.taskId,
                    name: title.text,
                    description: details.text,
                    date_time: date != null ? date.toString() : null,
                  );
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
