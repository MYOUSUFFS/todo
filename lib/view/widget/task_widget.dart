import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider.dart';
import '../../model/task.dart';
import '../utils/date_time.dart';
import '../utils/date_view.dart';

class TaskInput extends StatefulWidget {
  TaskInput({super.key});

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
        decoration: InputDecoration(
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: details,
            decoration: InputDecoration(
              // isCollapsed: true,
              hintText: "Details",
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.grey, fontSize: 14),
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
                  Icon(Icons.calendar_today),
                  SizedBox(width: 5),
                  Text(date != null ? myDateFormate(date!) : " Date/Time"),
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
                icon: Icon(
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
                      taskCreate: DateTime.now().toString());
                  provider.addNewTaskToList(task);
                  Navigator.pop(context);
                },
                icon: Icon(
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
    if (taskDate.isBefore(now))
      return Colors.red; // If the task is overdue, show it in red color
    else if ((taskDate.day - now.day) <= 1 &&
        (taskDate.month == now.month || taskDate.year == now.year))
      return Colors.orange;
    else
      return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    // print("${task.taskEndDate}");
    return ListTile(
      leading: Icon(Icons.circle_outlined),
      title: Text(
        '${task.taskName}',
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (task.taskDescription != null) ...[
            Text(
              task.taskDescription!,
              style: TextStyle(
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return ListTile(
      title: TextFormField(
        autofocus: true,
        controller: title,
        decoration: InputDecoration(
          hintText: "Title",
          border: InputBorder.none,
        ),
      ),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: details,
            decoration: InputDecoration(
              // isCollapsed: true,
              hintText: "Details",
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.grey, fontSize: 14),
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
                children: [],
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
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  //  TaskList  _task =  TaskList(taskName: taskName, taskStatus: taskStatus, taskCreate: taskCreate)
                  // provider.editTaskToList(_task);
                  Navigator.pop(context);
                },
                icon: Icon(
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
