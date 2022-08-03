import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/basic_utils.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<TaskProvider>().tasks.isEmpty) {
      return Column(
        children: [
          Image(
            image: const AssetImage('res/gifs/emptyList.gif'),
            height: 40.h,
            width: 80.w,
          ),
          Text(
            "No tasks yet",
            style: GoogleFonts.rubik(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
    return CarouselSlider.builder(
        itemCount: context.watch<TaskProvider>().tasks.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          Color curColor = Colors.white;
          Color textColor = Colors.white;
          if (context.watch<TaskProvider>().tasks[itemIndex][2] == 'urgent') {
            curColor = BasicUtils().urgentColor;
            textColor = Colors.white;
          } else if (context.watch<TaskProvider>().tasks[itemIndex][2] ==
              'medium') {
            curColor = BasicUtils().mediumColor;
            textColor = Colors.white;
          } else {
            curColor = BasicUtils().leisureColor;
            textColor = Colors.white;
          }
          var dt = BasicUtils().timeStampToDT(
              (context.watch<TaskProvider>().tasks[itemIndex][1] as Timestamp)
                  .toDate()
                  .toString());
          return SizedBox(
            width: 70.w,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.h)),
              color: curColor,
              child: Padding(
                padding: EdgeInsets.all(1.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(BasicUtils().dtToString(dt),
                          style: GoogleFonts.rubik(
                              color: textColor, fontSize: 0.28.dp)),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Text(
                            context.watch<TaskProvider>().tasks[itemIndex][0],
                            style: GoogleFonts.rubik(
                                color: textColor, fontSize: 0.28.dp)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              iconSize: 0.36.dp,
                              onPressed: () {
                                context.read<TaskProvider>().deleteTask(context
                                    .read<TaskProvider>()
                                    .tasks[itemIndex]);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: textColor,
                              )),
                          IconButton(
                              iconSize: 0.36.dp,
                              onPressed: () {
                                context.read<TaskProvider>().taskDone(context
                                    .read<TaskProvider>()
                                    .tasks[itemIndex]);
                              },
                              icon: Icon(
                                Icons.check,
                                color: textColor,
                              ))
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
        options: CarouselOptions(
            height: 34.h,
            enableInfiniteScroll: false,
            viewportFraction: 0.7,
            enlargeCenterPage: true));
  }
}
