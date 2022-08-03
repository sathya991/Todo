import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/providers/task_provider.dart';

class TextShow extends StatelessWidget {
  const TextShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Text(
          "Hey ${context.watch<LoginSignupProvider>().userName}, You have ${context.watch<TaskProvider>().tasks.length} tasks left",
          style: GoogleFonts.rubik(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500)),
    );
  }
}
