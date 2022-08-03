import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/basic_utils.dart';

class TaskProvider extends ChangeNotifier {
  List _tasks = [];
  List get tasks => _tasks;
  List _urgentDoneTasks = [];
  List get urgentDoneTasks => _urgentDoneTasks;
  List _mediumDoneTasks = [];
  List get mediumDoneTasks => _mediumDoneTasks;
  List _leisureDoneTasks = [];
  List get leisureDoneTasks => _leisureDoneTasks;

  List _curTasks = [];
  List get curTasks => _curTasks;
  getUrgentTasks() async {
    _tasks.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('urgent')
        .where('status', isNotEqualTo: "done")
        .get()
        .then((value) {
      for (var element in value.docs) {
        _tasks.add([
          element.get('task'),
          element.get('time'),
          element.get('type'),
          element.get('id')
        ]);
      }

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
        .where('status', isNotEqualTo: "done")
        .get()
        .then((value) {
      for (var element in value.docs) {
        _tasks.add([
          element.get('task'),
          element.get('time'),
          element.get('type'),
          element.get('id')
        ]);
      }

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
        .where('status', isNotEqualTo: "done")
        .get()
        .then((value) {
      for (var element in value.docs) {
        _tasks.add([
          element.get('task'),
          element.get('time'),
          element.get('type'),
          element.get('id')
        ]);
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

  deleteTask(List task) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection(task[2])
        .where('id', isEqualTo: task[3])
        .get()
        .then((value) {
      value.docs.first.reference.delete();
      _tasks.remove(task);
      notifyListeners();
    });
  }

  taskDone(List task) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection(task[2])
        .where('id', isEqualTo: task[3])
        .get()
        .then((value) {
      value.docs.first.reference.update({"status": "done"});
      _tasks.remove(task);
      if (task[2] == 'urgent') {
        _urgentDoneTasks.add(task);
      } else if (task[2] == 'medium') {
        _mediumDoneTasks.add(task);
      } else {
        _leisureDoneTasks.add(task);
      }
      notifyListeners();
    });
  }

  getUrgentDoneTasks() {
    _urgentDoneTasks.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('urgent')
        .where('status', isEqualTo: "done")
        .get()
        .then((value) {
      for (var element in value.docs) {
        _urgentDoneTasks.add(element.data());
        notifyListeners();
      }
    });
  }

  getMediumDoneTasks() {
    _urgentDoneTasks.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('medium')
        .where('status', isEqualTo: "done")
        .get()
        .then((value) {
      for (var element in value.docs) {
        _mediumDoneTasks.add(element.data());
        notifyListeners();
      }
    });
  }

  getLeisureDoneTasks() {
    _urgentDoneTasks.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection('leisure')
        .where('status', isEqualTo: "done")
        .get()
        .then((value) {
      for (var element in value.docs) {
        _leisureDoneTasks.add(element.data());
        notifyListeners();
      }
    });
  }

  taskNotDone(Map task) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(BasicUtils().curUserUid)
        .collection(task['type'])
        .where('id', isEqualTo: task['id'])
        .get()
        .then((value) {
      List temp = [];
      temp.add(task['task']);
      temp.add(task['time']);
      temp.add(task['type']);
      temp.add(task['id']);
      value.docs.first.reference.update({"status": ""});
      _tasks.add(temp);
      if (task['type'] == 'urgent') {
        _urgentDoneTasks.remove(task);
      } else if (task['type'] == 'medium') {
        _mediumDoneTasks.remove(task);
      } else {
        _leisureDoneTasks.remove(task);
      }
      notifyListeners();
    });
  }
}
