import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List _tasks = [];
  List get tasks => _tasks;

  List _curTasks = [];
  List get curTasks => _curTasks;
//   bool _optionOpen = false;
//   bool get optionsOpen => _optionOpen;

//   clickOpenOptions(bool open) {
//     if (open) {
//       _optionOpen = false;
//     }
//     _optionOpen = true;
//     notifyListeners();
//   }

  addTask(String task) {
    _curTasks.add(task);
    notifyListeners();
  }

  removeTask(int index) {
    _curTasks.removeAt(index);
    notifyListeners();
  }

  clearCurList() {
    _curTasks.clear();
  }
}
