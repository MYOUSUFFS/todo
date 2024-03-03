import 'package:flutter/material.dart';
import '../../utils/const.dart';
import 'new_task.dart';
import 'uncompleted_task.dart';

class MyTask extends StatelessWidget {
  const MyTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
        Visibility(
          visible: false,
          child: Expanded(
            child: UncompletedTask(),
          ),
        ),
        Visibility(
          visible: true,
          child: Expanded(
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
        ),
        ListTile(
          leading: Icon(Icons.arrow_right_outlined),
          title: Text("Completed"),
          onTap: () {},
        )
        // Text("data"),
      ],
    );
  }
}
