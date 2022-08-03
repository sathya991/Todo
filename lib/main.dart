import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:todo/providers/image_provider.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/providers/prof_pic_provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/login_signup.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/utils/router_utils.dart';
import 'package:todo/widgets/task_list.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginSignupProvider>(
      create: (_) => LoginSignupProvider(),
    ),
    ChangeNotifierProvider<RandomImageProvider>(
      create: (_) => RandomImageProvider(),
    ),
    ChangeNotifierProvider<ProfPicProvider>(
      create: (_) => ProfPicProvider(),
    ),
    ChangeNotifierProvider<TaskProvider>(
      create: (_) => TaskProvider(),
    ),
  ], child: const MyApp()));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        title: 'Todo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: BasicUtils().allColor,
        )),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        home: SplashScreen.navigate(
          name: 'res/rive/todorive.riv',
          next: (context) => FirebaseAuth.instance.currentUser != null
              ? const Dashboard()
              : LoginSignupScreen(),
          until: () => Future.delayed(const Duration(seconds: 3)),
          backgroundColor: BasicUtils().allColor,
          loopAnimation: "Animation 1",
        ),
      );
    });
  }
}
