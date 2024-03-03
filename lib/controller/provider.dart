import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';

class MainProvider with ChangeNotifier {
  List<Task> _task = [];
  List<Task> get task => _task;

  int currentTaskIs = 0;

  // --------- New Task Title  -----------
  addTaskTitle(String title) {
    _task.add(
      Task(
        taskTitle: title,
        taskList: [],
      ),
    );
    currentTaskIs = _task.length - 1;
    notifyListeners();
  }

  deleteTaskTitleWithThatList(int taskIndex) {
    _task.removeAt(taskIndex);
    notifyListeners();
  }
  // --- End of New Task Title ----

  // ------- Adding a new Task to the list --------
  addNewTaskToList(TaskList task) {
    _task[currentTaskIs].taskList!.add(task);
    notifyListeners();
  }

  editTaskToList(TaskList task) {
    int subTaskIndex = _task[currentTaskIs]
        .taskList!
        .indexWhere((e) => e.taskCreate == task.taskCreate);
    _task[currentTaskIs].taskList![subTaskIndex] = task;
    notifyListeners();
  }

  removeTaskFromList(int subTaskIndex) {
    _task[currentTaskIs].taskList!.removeAt(subTaskIndex);
    notifyListeners();
  }
  //  ----- End of Adding a new Task to the list ------
}
