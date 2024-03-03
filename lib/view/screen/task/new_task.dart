import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/model/task.dart';
import 'package:todo/view/utils/date_time.dart';
import 'package:todo/view/utils/date_view.dart';

final TextEditingController heading = TextEditingController();
newTaskTitle(BuildContext context) {
  final provider = Provider.of<MainProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("New Heading"),
          content: TextFormField(
            controller: heading,
            decoration: InputDecoration(
              hintText: "Heading",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                provider.addTaskTitle(heading.text);
                Navigator.pop(context);
              },
              child: Text("Submit"),
            )
          ],
        );
      });
}

newTaskAdded(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create your new task"),
          content: SizedBox(
              width: MediaQuery.of(context).size.width, child: TaskInput()),
        );
      });
}

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

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
    final provider = Provider.of<MainProvider>(context, listen: false);

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
                      taskEndDate: date.toString(),
                      taskStatus: false,
                      taskCreate: DateTime.now().toString());
                  provider.addNewTaskToList(task);
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
