import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatelessWidget {
  static const String addTaskRoute = '/add-task-route';

  AddTask(this.color, this.contrastColor, this.appBarString,
      this.firebaseCollectionString,
      {Key? key})
      : super(key: key);
  final Color color;
  final Color contrastColor;
  final String appBarString;
  final String firebaseCollectionString;

  final fieldText = TextEditingController();
  var uuid = const Uuid();
  @override
  Widget build(BuildContext context) {
    List tasks = context.watch<TaskProvider>().curTasks;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: contrastColor),
          title: Text(
            appBarString,
            style: GoogleFonts.rubik(color: contrastColor),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: contrastColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    if (tasks.isNotEmpty) {
                      for (int i = 0; i < tasks.length; i++) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(BasicUtils().curUserUid)
                            .collection(firebaseCollectionString)
                            .doc()
                            .set({
                          'id': uuid.v4(),
                          'task': tasks[i],
                          'time': DateTime.now(),
                          'type': firebaseCollectionString,
                          'status': ''
                        });
                      }
                      context.read<TaskProvider>().clearCurList();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Dashboard.dashboardRoute, (route) => false);
                    }
                  },
                  child: Text(
                    "Add",
                    style: GoogleFonts.rubik(
                      color: color,
                      fontSize: 16,
                    ),
                  )),
            )
          ],
          backgroundColor: color,
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tasks[index],
                                style: firebaseCollectionString == "medium"
                                    ? GoogleFonts.rubik(
                                        color: contrastColor, fontSize: 18)
                                    : GoogleFonts.rubik(
                                        color: color, fontSize: 18),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<TaskProvider>()
                                        .removeTask(index);
                                  },
                                  icon: firebaseCollectionString == "medium"
                                      ? Icon(
                                          Icons.delete,
                                          color: contrastColor,
                                        )
                                      : Icon(
                                          Icons.delete,
                                          color: color,
                                        ))
                            ],
                          ),
                        ),
                      );
                    }))),
            const Divider(
              thickness: 2,
            ),
            Container(
              color: Colors.white10,
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                        controller: fieldText,
                        style: firebaseCollectionString == "medium"
                            ? GoogleFonts.rubik(
                                color: contrastColor, fontSize: 18)
                            : GoogleFonts.rubik(color: color, fontSize: 18),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 10, 0, 30),
                            hintText: "Enter your task",
                            hintStyle: firebaseCollectionString == "medium"
                                ? GoogleFonts.rubik(
                                    color: contrastColor, fontSize: 18)
                                : GoogleFonts.rubik(
                                    color: color, fontSize: 18))),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<TaskProvider>().addTask(fieldText.text);
                      fieldText.clear();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 20, 30),
                      child: firebaseCollectionString == "medium"
                          ? Icon(
                              Icons.add,
                              color: contrastColor,
                            )
                          : Icon(
                              Icons.add,
                              color: color,
                            ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
