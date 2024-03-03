import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';

class MainProvider with ChangeNotifier {
  List<Task> _task = [];
  List<Task> get task => _task;

  // --------- New Task Title  -----------
  addTaskTitle(String title) {
    _task.add(
      Task(
        taskTitle: title,
        taskList: [],
      ),
    );
    notifyListeners();
  }

  deleteTaskTitleWithThatList(int taskIndex) {
    _task.removeAt(taskIndex);
    notifyListeners();
  }
  // --- End of New Task Title ----

  // ------- Adding a new Task to the list --------
  addNewTaskToList(TaskList task, int index) {
    _task[index].taskList!.add(task);
    notifyListeners();
  }

  editTaskToList(TaskList task, int index) {
    int subTaskIndex = _task[index]
        .taskList!
        .indexWhere((e) => e.taskCreate == task.taskCreate);
    _task[index].taskList![subTaskIndex] = task;
    notifyListeners();
  }

  removeTaskFromList(int index, int subTaskIndex) {
    _task[index].taskList!.removeAt(subTaskIndex);
    notifyListeners();
  }
  //  ----- End of Adding a new Task to the list ------
}
