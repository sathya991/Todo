import 'package:flutter/material.dart';
import 'package:todo/screens/add_task.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/screens/done_tasks.dart';
import 'package:todo/screens/login_signup.dart';
import 'package:todo/widgets/photo_viewer.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => LoginSignupScreen());
      case Dashboard.dashboardRoute:
        return MaterialPageRoute(builder: (context) => const Dashboard());
      case PhotoViewer.photoViewerRoute:
        return MaterialPageRoute(builder: (context) => const PhotoViewer());
      case DoneTasks.doneTaskRoute:
        return MaterialPageRoute(builder: (context) => const DoneTasks());
      case AddTask.addTaskRoute:
        return MaterialPageRoute(builder: (context) {
          AddTask argument = args as AddTask;
          return AddTask(argument.color, argument.contrastColor,
              argument.appBarString, argument.firebaseCollectionString);
        });
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return const Scaffold(
        body: Center(child: Text("No Page Found")),
      );
    });
  }
}
