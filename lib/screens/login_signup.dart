import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/widgets/login.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:provider/provider.dart';

class LoginSignupScreen extends StatelessWidget {
  LoginSignupScreen({Key? key}) : super(key: key);
  bool isLogin = true;
  final Widget curWidget = LoginWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50.h,
              width: 95.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("res/gifs/loginsignupback.gif"),
                      fit: BoxFit.contain)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 0.h),
              child: context.watch<LoginSignupProvider>().curWidget,
            ),
            TextButton(
              onPressed: () {
                context
                    .read<LoginSignupProvider>()
                    .loginOrSignupChange(isLogin);
                isLogin = !isLogin;
              },
              child: Text(
                context.watch<LoginSignupProvider>().curText,
                style: GoogleFonts.rubik(fontSize: 0.26.dp),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
