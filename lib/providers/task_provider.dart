import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/basic_utils.dart';

class TaskProvider extends ChangeNotifier {
  List _tasks = [];
  List get tasks => _tasks;

  List _curTasks = [];
  List get curTasks => _curTasks;
  getUrgentTasks() async {
    _tasks.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('urgent')
        .get()
        .then((value) {
      for (var element in value.docs) {
        _tasks.add(
            [element.get('task'), element.get('time'), element.get('type')]);
      }
      _tasks.sort((a, b) {
        return a[1].compareTo(b[1]);
      });
      sortList();
      notifyListeners();
    });
  }

  getMediumTasks() async {
    _tasks.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('medium')
        .get()
        .then((value) {
      for (var element in value.docs) {
        _tasks.add(
            [element.get('task'), element.get('time'), element.get('type')]);
      }
      _tasks.sort((a, b) {
        return a[1].compareTo(b[1]);
      });
      sortList();
      notifyListeners();
    });
  }

  getLeisureTasks() async {
    _tasks.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('leisure')
        .get()
        .then((value) {
      for (var element in value.docs) {
        _tasks.add(
            [element.get('task'), element.get('time'), element.get('type')]);
      }
      sortList();
      notifyListeners();
    });
  }

  sortList() {
    _tasks.sort((a, b) {
      return a[1].compareTo(b[1]);
    });
  }

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
