import 'package:flutter/material.dart';

class DoneTasks extends StatelessWidget {
  static const String doneTaskRoute = '/done-task-route';
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Done tasks"),
            bottom: TabBar(tabs: [
              Container(color: Colors.black, child: Text("Urgent")),
              Text("Not so Important"),
              Text("Leisure")
            ]),
          ),
        ));
  }
}
