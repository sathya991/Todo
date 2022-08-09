import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
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
              padding: EdgeInsets.all(1.h),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: contrastColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.h))),
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
                      fontSize: 17.sp,
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
                          padding: EdgeInsets.all(1.5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  tasks[index],
                                  style: GoogleFonts.rubik(
                                    color: color,
                                    fontSize: 17.sp,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<TaskProvider>()
                                        .removeTask(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: color,
                                    size: 20.sp,
                                  ))
                            ],
                          ),
                        ),
                      );
                    }))),
            Divider(
              thickness: 0.2.h,
            ),
            Container(
              color: Colors.white10,
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                        controller: fieldText,
                        style: GoogleFonts.rubik(
                          color: color,
                          fontSize: 17.sp,
                        ),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(5.w, 1.h, 0, 3.5.h),
                            hintText: "Enter your task",
                            hintStyle: GoogleFonts.rubik(
                              color: color,
                              fontSize: 18.sp,
                            ))),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<TaskProvider>().addTask(fieldText.text);
                      fieldText.clear();
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 1.h, 5.w, 3.5.h),
                      child: Icon(
                        Icons.add,
                        color: color,
                        size: 20.sp,
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
