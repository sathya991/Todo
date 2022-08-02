import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/add_task.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/utils/form_utils.dart';

class OptionPicker extends StatelessWidget {
  const OptionPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Add task",
          style: GoogleFonts.rubik(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const Divider(
          color: Colors.white,
          thickness: 2,
          endIndent: 100,
          indent: 100,
        ),
        ExpandChild(
            arrowColor: Colors.white,
            child: Column(
              children: [
                ElevatedButton(
                  style: FormUtils().urgentButtonStyle(),
                  onPressed: () {
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
                    Navigator.of(context).pushNamed(AddTask.addTaskRoute,
                        arguments: AddTask(BasicUtils().mediumColor,
                            Colors.black, "Not so urgent", "medium"));
                  },
                  child: Text(
                    "Not so urgent",
                    style: BasicUtils().mediumButtonTextStyle,
                  ),
                ),
                ElevatedButton(
                  style: FormUtils().leisureButtonStyle(),
                  onPressed: () {
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
      ],
    );
  }
}
