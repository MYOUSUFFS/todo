import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/provider.dart';
import 'package:todo/view/screen/task/task.dart';

import '../widget/box_shadow.dart';
import '../utils/new_task.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final String taskList = "MyTask";

  @override
  void initState() {
    final provider = Provider.of<MainProvider>(context, listen: false);
    provider.fetchTaskTitle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainProvider>(context);
    return GestureDetector(
      onTap: () {
        provider.closeAllOption();
      },
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: ListTile(
                  title: Text(
                    "Tasks".toUpperCase(),
                    style: const TextStyle(
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
                          const Text(
                            "Add Task",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.add_chart,
                          )
                        ] else ...[
                          Flexible(
                            child: Text(
                              "${provider.task[provider.currentTaskIs].taskTitle}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.arrow_drop_down_sharp)
                        ],
                      ],
                    ),
                  )),
              actions: [
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    provider.task.clear();
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  const MyTask(),
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
                            title: const Text("Create new list"),
                            leading: const Icon(Icons.post_add),
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
                                const Text(
                                  "Sort by",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const ListTile(
                                  title: Text("New First"),
                                  leading: Icon(Icons.done_rounded),
                                ),
                                const ListTile(
                                  title: Text("Old First"),
                                  leading: Icon(null),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.grey.shade300,
                                ),
                                const ListTile(
                                  title: Text("Rename"),
                                ),
                                const ListTile(
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
        ),
      ),
    );
  }
}
