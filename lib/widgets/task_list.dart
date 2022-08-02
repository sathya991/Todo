import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.watch<TaskProvider>().tasks.isEmpty) {
      return Column(
        children: [
          const Image(
            image: AssetImage('res/gifs/emptyList.gif'),
            height: 400,
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
    return Container();
  }
}
