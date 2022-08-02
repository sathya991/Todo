import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/basic_utils.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<TaskProvider>().tasks.isEmpty) {
      return Column(
        children: [
          const Image(
            image: AssetImage('res/gifs/emptyList.gif'),
            height: 350,
            width: 350,
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
          Color textColor = Colors.black;
          if (context.watch<TaskProvider>().tasks[itemIndex][2] == 'urgent') {
            curColor = BasicUtils().urgentColor;
            textColor = Colors.white;
          } else if (context.watch<TaskProvider>().tasks[itemIndex][2] ==
              'medium') {
            curColor = BasicUtils().mediumColor;
            textColor = Colors.black;
          } else {
            curColor = BasicUtils().leisureColor;
            textColor = Colors.white;
          }
          var dt = DateTime.parse(
              (context.watch<TaskProvider>().tasks[itemIndex][1] as Timestamp)
                  .toDate()
                  .toString());
          return SizedBox(
            width: 300,
            child: Card(
              color: curColor,
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('dd/MM/yyyy, hh:mm').format(dt),
                          style: GoogleFonts.rubik(
                              color: textColor, fontSize: 17)),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Text(
                            context.watch<TaskProvider>().tasks[itemIndex][0],
                            style: GoogleFonts.rubik(
                                color: textColor, fontSize: 17)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              iconSize: 30,
                              onPressed: () {},
                              icon: Icon(
                                Icons.delete,
                                color: textColor,
                              )),
                          IconButton(
                              iconSize: 30,
                              onPressed: () {},
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
            height: 300,
            enableInfiniteScroll: false,
            viewportFraction: 0.7,
            enlargeCenterPage: true));
  }
}
