import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/basic_utils.dart';

class ShowEachTaskList extends StatelessWidget {
  const ShowEachTaskList(this.taskList, this.textColor, this.contrastColor,
      {Key? key})
      : super(key: key);
  final List taskList;
  final Color textColor;
  final Color contrastColor;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          var curTask = taskList[index];
          var curTime = BasicUtils().timeStampToDT(
              (curTask['time'] as Timestamp).toDate().toString());
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task:",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        curTask['task'],
                        style:
                            GoogleFonts.rubik(fontSize: 18, color: textColor),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Time:",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: textColor),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        BasicUtils().dtToString(curTime),
                        style:
                            GoogleFonts.rubik(fontSize: 14, color: textColor),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: textColor),
                      onPressed: () {
                        context
                            .read<TaskProvider>()
                            .taskNotDone(taskList[index]);
                      },
                      child: Text(
                        "Not done",
                        style: GoogleFonts.rubik(
                            color: contrastColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            )),
          );
        });
  }
}
