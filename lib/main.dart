import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/login_signup.dart';
import 'package:todo/utils/basic_style_utils.dart';
import 'package:todo/utils/router_utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LoginSignupProvider())],
      child: const MyApp()));
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 2));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: BasicStyleUtils().allColor,
      )),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: SplashScreen.navigate(
        name: 'res/rive/todorive.riv',
        next: (context) => FirebaseAuth.instance.currentUser != null
            ? const Dashboard()
            : LoginSignupScreen(),
        until: () => Future.delayed(const Duration(seconds: 3)),
        backgroundColor: BasicStyleUtils().allColor,
        loopAnimation: "Animation 1",
      ),
    );
  }
}
