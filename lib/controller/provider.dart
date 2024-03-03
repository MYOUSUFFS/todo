import 'package:flutter/material.dart';
import 'package:todo/model/task.dart';

class MainProvider with ChangeNotifier {
  List<Task> _task = [];
  List<Task> get task => _task;

  int currentTaskIs = 0;

  changeCurrentTask(int index) {
    currentTaskIs = index;
    notifyListeners();
  }

  bool _mainTaskOption = false;
  bool get mainTaskOption => _mainTaskOption;

  doMainTaskOptions() {
    _mainTaskOption = !_mainTaskOption;
    _subTaskOption = false;
    notifyListeners();
  }

  bool _subTaskOption = false;
  bool get subTaskOption => _subTaskOption;

  doSubTaskOptions() {
    _subTaskOption = !_subTaskOption;
    _mainTaskOption = false;
    notifyListeners();
  }

  closeAllOption() {
    _mainTaskOption = false;
    _subTaskOption = false;
    notifyListeners();
  }

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

  editTaskToList(
    String taskId, {
    String? name,
    String? description,
    String? date_time,
  }) {
    int subTaskIndex =
        _task[currentTaskIs].taskList!.indexWhere((e) => e.taskId == taskId);
    _task[currentTaskIs].taskList![subTaskIndex].taskName = "${name}";
    _task[currentTaskIs].taskList![subTaskIndex].taskDescription = description;
    _task[currentTaskIs].taskList![subTaskIndex].taskEndDate = date_time;
    notifyListeners();
  }

  removeTaskFromList(String taskId) {
    final _taskList = _task[currentTaskIs].taskList;
    if (_taskList != null)
      _taskList.removeAt(
        _taskList.indexWhere((element) => element.taskId == taskId),
      );
    notifyListeners();
  }
  //  ----- End of Adding a new Task to the list ------
}
