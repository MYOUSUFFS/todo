import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/view/screen/task/task.dart';

import '../widget/box_shadow.dart';
import 'task/new_task.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  final String taskList = "MyTask";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(
      context,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: ListTile(
            title: Text(
              "Tasks".toUpperCase(),
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            subtitle: InkWell(
              onTap: () {
                if (provider.task.isEmpty) {
                  newTaskTitle(context);
                } else {}
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (provider.task.isEmpty) ...[
                    Text(
                      "Add Task",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.add_chart,
                    )
                  ] else ...[
                    Text(
                      "${provider.task[provider.currentTaskIs].taskTitle}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_drop_down_sharp)
                  ],
                ],
              ),
            )),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            MyTask(),
            Visibility(
              visible: false,
              child: MyBoxShadow(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: Text("$taskList"),
                      leading: Icon(Icons.done_rounded),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    ListTile(
                      title: Text("Create new list"),
                      leading: Icon(Icons.post_add),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 10),
                  child: MyBoxShadow(
                    top: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text(
                            "Sort by",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            title: Text("New First"),
                            leading: Icon(Icons.done_rounded),
                          ),
                          ListTile(
                            title: Text("Old First"),
                            leading: Icon(null),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),
                          ListTile(
                            title: Text("Rename"),
                          ),
                          ListTile(
                            title: Text("Delete list"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
