import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/widgets/show_task_list.dart';
import 'package:provider/provider.dart';

class DoneTasks extends StatefulWidget {
  static const String doneTaskRoute = '/done-task-route';
  const DoneTasks({Key? key}) : super(key: key);

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  int _selectedIndex = 0;
  Color? color = BasicUtils().urgentColor;
  Color? contrastColor = Colors.white;
  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 3, vsync: this);
    context.read<TaskProvider>().getUrgentDoneTasks();
    context.read<TaskProvider>().getMediumDoneTasks();
    context.read<TaskProvider>().getLeisureDoneTasks();
    _controller!.addListener(() {
      if (_controller!.index == 0) {
        setState(() {
          color = BasicUtils().urgentColor;
          contrastColor = Colors.white;
        });
      } else if (_controller!.index == 1) {
        setState(() {
          color = BasicUtils().mediumColor;
          contrastColor = Colors.white;
        });
      } else {
        setState(() {
          color = BasicUtils().leisureColor;
          contrastColor = Colors.white;
        });
      }
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          foregroundColor: contrastColor,
          centerTitle: false,
          title: const Text("Done tasks"),
          bottom: TabBar(controller: _controller, tabs: [
            Text(
              "Urgent",
              style: GoogleFonts.rubik(
                  color: contrastColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Not so Important",
                style: GoogleFonts.rubik(
                    color: contrastColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "Leisure",
              style: GoogleFonts.rubik(
                  color: contrastColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ]),
        ),
        body: TabBarView(controller: _controller, children: [
          ShowEachTaskList(context.watch<TaskProvider>().urgentDoneTasks,
              BasicUtils().urgentColor, Colors.white),
          ShowEachTaskList(context.watch<TaskProvider>().mediumDoneTasks,
              BasicUtils().mediumColor, Colors.white),
          ShowEachTaskList(context.watch<TaskProvider>().leisureDoneTasks,
              BasicUtils().leisureColor, Colors.white),
        ]));
  }
}
