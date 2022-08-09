import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/add_task.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/utils/form_utils.dart';

class OptionPicker extends StatelessWidget {
  const OptionPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 3.5.h),
          child: ExpandChild(
              indicatorBuilder: (context, onTap, expanded) {
                return InkWell(
                  hoverColor: Colors.white,
                  onTap: onTap,
                  child: Column(
                    children: [
                      expanded
                          ? Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 23.sp)
                          : Icon(
                              Icons.keyboard_arrow_up,
                              color: Colors.white,
                              size: 23.sp,
                            ),
                      Text(
                        "Add task",
                        style: GoogleFonts.rubik(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
              child: Column(
                children: [
                  ElevatedButton(
                    style: FormUtils().urgentButtonStyle(),
                    onPressed: () {
                      context.read<TaskProvider>().clearTask();
                      Navigator.of(context).pushNamed(AddTask.addTaskRoute,
                          arguments: AddTask(BasicUtils().urgentColor,
                              Colors.white, "Urgent", "urgent"));
                    },
                    child: Text(
                      "Urgent",
                      style: BasicUtils().buttonTextStyle,
                    ),
                  ),
                  ElevatedButton(
                    style: FormUtils().mediumButtonStyle(),
                    onPressed: () {
                      context.read<TaskProvider>().clearTask();
                      Navigator.of(context).pushNamed(AddTask.addTaskRoute,
                          arguments: AddTask(BasicUtils().mediumColor,
                              Colors.white, "Not so urgent", "medium"));
                    },
                    child: Text(
                      "Not so urgent",
                      style: BasicUtils().buttonTextStyle,
                    ),
                  ),
                  ElevatedButton(
                    style: FormUtils().leisureButtonStyle(),
                    onPressed: () {
                      context.read<TaskProvider>().clearTask();
                      Navigator.of(context).pushNamed(AddTask.addTaskRoute,
                          arguments: AddTask(BasicUtils().leisureColor,
                              Colors.white, "Leisure", "leisure"));
                    },
                    child: Text(
                      "Leisure",
                      style: BasicUtils().buttonTextStyle,
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}
