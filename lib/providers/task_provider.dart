import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List _tasks = [];
  List get tasks => _tasks;
//   bool _optionOpen = false;
//   bool get optionsOpen => _optionOpen;

//   clickOpenOptions(bool open) {
//     if (open) {
//       _optionOpen = false;
//     }
//     _optionOpen = true;
//     notifyListeners();
//   }
}
