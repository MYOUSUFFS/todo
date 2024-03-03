import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/view/screen/task/task.dart';

import '../widget/box_shadow.dart';
import '../utils/new_task.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});
  final String taskList = "MyTask";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.closeAllOption();
      },
      child: Scaffold(
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
                  } else {
                    provider.doMainTaskOptions();
                  }
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          "${provider.task[provider.currentTaskIs].taskTitle}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                visible: provider.mainTaskOption,
                child: MyBoxShadow(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.task.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                              "${provider.task[index].taskTitle}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: Icon(
                              index == provider.currentTaskIs
                                  ? Icons.done_rounded
                                  : null,
                            ),
                            onTap: () {
                              provider.changeCurrentTask(index);
                            },
                          ),
                        ),
                      ),
                      Divider(thickness: 1, color: Colors.grey.shade300),
                      ListTile(
                        title: Text("Create new list"),
                        leading: Icon(Icons.post_add),
                        onTap: () {
                          newTaskTitle(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: provider.subTaskOption,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, right: 10),
                    child: MyBoxShadow(
                      top: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }
}
